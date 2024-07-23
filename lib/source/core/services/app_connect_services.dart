import 'dart:async';

import 'package:counter/source/core/values/enums/app_status_enum.dart';
import 'package:counter/source/core/values/enums/bluetooth_status_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:rxdart/rxdart.dart';

import '../utils/app_permission_utils.dart';

class AppConnectServices
    with AppConnectServicesInputs, AppConnectServicesOutputs {
  ///region parameter
  final StreamController _imageDataStreamController =
      BehaviorSubject<Uint8List>();

  final StreamController _shapeNameDataStreamController =
      BehaviorSubject<String>();

  final StreamController _bluetoothStateStreamController =
      BehaviorSubject<BluetoothStatusEnum>();

  final StreamController _dashboardStateStreamController =
      BehaviorSubject<AppStatusEnum>();

  final StreamController _blueDevicesStreamController =
      BehaviorSubject<List<BluetoothDevice>>();

  final StreamController _connectingDeviceStreamController =
      BehaviorSubject<BluetoothDevice>();

  final String serviceUUID = "f9db461d-cc63-45ed-b796-c4ec40818990";

  final String characteristicWriteDataUUID =
      "b8a76511-6950-46c6-99a7-24729ce5a2e2";

  final String characteristicReadDataUUID =
      "972290f3-e0f6-4a44-8ace-e554f7392479";

  ///region Request Message
  List<int> getCountersData = [82, 59]; //[R;]
  List<int> runCounters = [83, 59]; //[S;]

  StreamSubscription<List<int>>? _readStreamSubscription;

  late BluetoothDevice device;

  BluetoothCharacteristic? readCharacteristic, writeCharacteristic;

  List<int> message = [];

  bool isReciving = false;

  final List<BluetoothDevice> devicesList = [];

  late BuildContext context;
  bool _isSearching = false;

  ///endregion Parameter

  ///region function

  void dispose() {
    _imageDataStreamController.close();
    _shapeNameDataStreamController.close();
    _bluetoothStateStreamController.close();
    _dashboardStateStreamController.close();
    _blueDevicesStreamController.close();

    if (_readStreamSubscription != null) {
      _readStreamSubscription!.cancel();
    }
  }

  void start(BuildContext ctx) {
    changeDashboardState.add(AppStatusEnum.empty);
    context = ctx;
  }

  Future<bool> _checkBluetoothRequirements() async {
    bool bluetoothIsEnable =
        await FlutterBluePlus.adapterState.first == BluetoothAdapterState.on;

    if (!bluetoothIsEnable) {
      _bluetoothStateStreamController.add(BluetoothStatusEnum.disable);
    }

    return (bluetoothIsEnable);
  }

  _discoverServices() async {
    List<BluetoothService> services = await device.discoverServices();
    for (var service in services) {
      if (kDebugMode) {
        print('Service');
        print(service.uuid);
      }

      for (var characteristic in service.characteristics) {
        if (kDebugMode) {
          print('>>>>>characteristic');
          print('>>>>>${characteristic.uuid}');
        }
      }

      if (service.uuid.toString() == serviceUUID) {
        for (var characteristic in service.characteristics) {
          if (characteristic.uuid.toString() == characteristicReadDataUUID) {
            characteristic.setNotifyValue(true);
            readCharacteristic = characteristic;
            _receiveMessage();
          }

          if (characteristicWriteDataUUID == characteristic.uuid.toString()) {
            writeCharacteristic = characteristic;
            //  print("write");
          }
        }
      }
    }
  }

  _receiveMessage() async {
    _readStreamSubscription = readCharacteristic!.lastValueStream.listen(
      (value) {
        if (value.isNotEmpty) {
          if (!isReciving) {
            isReciving = true;
            changeDashboardState.add(AppStatusEnum.loading);
          }
          _handleMessage(value);
        }
      },
    );
  }

  void _failedToConnect() {
    _bluetoothStateStreamController.add(BluetoothStatusEnum.failedToConnect);
  }

  void _handleMessage(List<int> range) {
    message.addAll(range.toList());
    if (kDebugMode) {
      print(' RX Message:$range');
      print(' Message length:${message.length}');
    }

    if (message.length >= 230401) {
      _getMessage([...message]);
      message.clear();
    }
  }

  _getMessage(List<int> messageD) {
    isReciving = false;
  }

  write(List<int> x) async {
    bool isAllValid = await _checkBluetoothRequirements();
    if (isAllValid && writeCharacteristic != null) {
      await Future.delayed(const Duration(milliseconds: 100));
      writeCharacteristic?.write(x);
    }
  }

  ///region input
  @override
  connectWithDevice(BluetoothDevice deviceToConnect,
      {isReconnecting = false}) async {
    addConnectingDevice.add(deviceToConnect);
    _isSearching = false;
    _bluetoothStateStreamController.add(BluetoothStatusEnum.enable);
    await deviceToConnect
        .connect()
        .whenComplete(
          () {
            device = deviceToConnect;

            _bluetoothStateStreamController.add(BluetoothStatusEnum.connected);

            device.connectionState.listen(
              (event) async {
                if (kDebugMode) {
                  print("<<<<<<<<<<<<<<<${event.name}>>>>>>>>>>>>>>>");
                }
                if (event == BluetoothConnectionState.connected) {
                  if (!isReconnecting) {
                    _discoverServices();
                  }
                }

                if (event == BluetoothConnectionState.disconnected) {
                  bool isAllValid = await _checkBluetoothRequirements();
                  if (isAllValid) {
                    _bluetoothStateStreamController
                        .add(BluetoothStatusEnum.failedToConnect);
                  }
                }
              },
            );
          },
        )
        .timeout(const Duration(seconds: 15), onTimeout: _failedToConnect)
        .onError(
          (error, stackTrace) {
            if (kDebugMode) {
              print("<<<<error>>>>");
              print(error);
            }
            _failedToConnect();
          },
        );
  }

  @override
  disconnect() {
    device.disconnect();
  }

  @override
  reconnect() {
    _bluetoothStateStreamController.add(BluetoothStatusEnum.enable);
    device.disconnect();
    connectWithDevice(device, isReconnecting: true);
  }

  @override
  startScan() {
    _scanStream();
  }

  @override
  set setNumberOfCounter(int numberOfCounter) => numberOfCounter;

  @override
  Sink get changeBluetoothState => _bluetoothStateStreamController.sink;

  @override
  Sink get receiveCountersData => _imageDataStreamController.sink;

  @override
  Sink get receiveCounterSettingsData => _shapeNameDataStreamController.sink;

  @override
  Sink get changeDashboardState => _dashboardStateStreamController.sink;

  @override
  Sink get addBluetoothDevice => _blueDevicesStreamController.sink;

  @override
  Sink get addConnectingDevice => _connectingDeviceStreamController.sink;

  ///region output
  @override
  Stream<BluetoothStatusEnum> get outBluetoothState =>
      _bluetoothStateStreamController.stream
          .map((bluetoothState) => bluetoothState);

  @override
  Stream<Uint8List> get outCountersData =>
      _imageDataStreamController.stream.map((data) => data);

  @override
  Stream<String> get outCountersSettings =>
      _shapeNameDataStreamController.stream.map((data) => data);

  @override
  Stream<AppStatusEnum> get outDashboardState =>
      _dashboardStateStreamController.stream.map((state) => state);

  @override
  Stream<List<BluetoothDevice>> get outBluetoothDevices =>
      _blueDevicesStreamController.stream.map((device) => device);

  @override
  Stream<BluetoothDevice> get outConnectingDevice =>
      _connectingDeviceStreamController.stream.map((device) => device);

  /// region function
  _addDeviceToList(final BluetoothDevice device) {
    if (!devicesList.contains(device)) {
      devicesList.add(device);
      addBluetoothDevice.add(devicesList.toList());
    }
  }

  void _scanStream() {
    for (BluetoothDevice device in FlutterBluePlus.connectedDevices) {
      _addDeviceToList(device);
    }
    FlutterBluePlus.scanResults.listen((List<ScanResult> results) {
      for (ScanResult result in results) {
        result.advertisementData.manufacturerData.values.toList();
        if (context.mounted) _addDeviceToList(result.device);
      }
    });
    _scanBluetoothDevices(context);
  }

  Future<void> _scanBluetoothDevices(BuildContext context) async {
    bool check = await AppPermissionUtils().checkAll(() {
      _scanBluetoothDevices(context);
    }, context);
    if (check) {
      _bluetoothStateStreamController.add(BluetoothStatusEnum.searching);
      await FlutterBluePlus.stopScan();
      if (context.mounted) {
        _isSearching = true;
      }

      FlutterBluePlus.startScan(
        timeout: const Duration(seconds: 15),
      ).asStream().listen((event) {});
      _stopScanTimer();
    }
  }

  Future<void> _stopScanTimer() async {
    await Future.delayed(const Duration(seconds: 15));
    if (_isSearching) {
      _bluetoothStateStreamController.add(BluetoothStatusEnum.enable);
      _isSearching = false;
    }
  }
}

mixin AppConnectServicesInputs {
  connectWithDevice(BluetoothDevice deviceToConnect, {isReconnecting = false});

  disconnect();

  reconnect();

  startScan();

  set setNumberOfCounter(int numberOfCounter);

  Sink get receiveCountersData;

  Sink get receiveCounterSettingsData;

  Sink get changeBluetoothState;

  Sink get changeDashboardState;

  Sink get addBluetoothDevice;

  Sink get addConnectingDevice;
}

mixin AppConnectServicesOutputs {
  Stream<Uint8List> get outCountersData;

  Stream<String> get outCountersSettings;

  Stream<BluetoothStatusEnum> get outBluetoothState;

  Stream<BluetoothDevice> get outConnectingDevice;

  Stream<AppStatusEnum> get outDashboardState;

  Stream<List<BluetoothDevice>> get outBluetoothDevices;
}
