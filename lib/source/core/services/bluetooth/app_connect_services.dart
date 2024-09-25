import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:counter/source/core/extensions/logger_extension.dart';
import 'package:counter/source/core/extensions/string_extension.dart';
import 'package:counter/source/core/services/api/errors/error_types.dart';
import 'package:counter/source/core/services/api/network_response/response_data.dart';
import 'package:counter/source/core/services/api/network_response/result.dart';
import 'package:counter/source/core/themes/app_colors.dart';
import 'package:counter/source/core/translations/app_strings.dart';
import 'package:counter/source/core/utils/app_permission_utils.dart';
import 'package:counter/source/core/values/constant/app_settings.dart';
import 'package:counter/source/core/values/enums/app_enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

import 'package:rxdart/rxdart.dart';

class AppConnectServices
    with AppConnectServicesInputs, AppConnectServicesOutputs {
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

  late StreamSubscription<List<ScanResult>> _scanResultsSubscription;

  /// region Request Message

  List<int> getCountersData = [82, 59]; // Request for Data Translation [R ;]
  List<int> runCounters = [83, 59]; // Run (active counter) [S ;]
  List<int> resetCounters = [68, 59]; // reset (active counter) [D ;]
  List<int> getSettingsModule = [
    71,
    59
  ]; // Request settings from the module [G ;]
  List<int> openGates = [80, 59]; // Open the gates [P ;]

  ///TODO:Request Message

  //endregion
  // Region Params
  StreamSubscription<List<int>>? readStreamSubscription;
  StreamSubscription<BluetoothConnectionState>? _bleStatusStreamSubscription;

  late BluetoothDevice device;
  BluetoothDevice? searchDevice;

  BluetoothCharacteristic? readCharacteristic, writeCharacteristic;

  List<int> message = [];

  bool isReceiving = false;

  final RxList<BluetoothDevice> devicesList = <BluetoothDevice>[].obs;

  RxBool isSearching = false.obs;

  late Timer reconnectTimer;

  String messageFromBle = '';

  Timer? _timer;
  Completer? _completer;

  //Function

  void dispose() {
    _bluetoothStateStreamController.close();
    _dashboardStateStreamController.close();
    _blueDevicesStreamController.close();
    _connectingDeviceStreamController.close();

    if (readStreamSubscription != null) {
      readStreamSubscription!.cancel();
    }

    if (_bleStatusStreamSubscription != null) {
      _bleStatusStreamSubscription!.cancel();
    }

    _timer?.cancel();
    _completer?.complete();
  }

  Future<bool> _checkBluetoothRequirements() async {
    bool bluetoothIsEnable =
        await FlutterBluePlus.adapterState.first == BluetoothAdapterState.on;

    if (!bluetoothIsEnable) {
      _bluetoothStateStreamController.add(BluetoothStatusEnum.disable);
    }

    return (bluetoothIsEnable);
  }

  //inputs

  _addDeviceToList(final BluetoothDevice device) {
    if (!devicesList.contains(device)) {
      devicesList.add(device);
      addBluetoothDevice.add(devicesList.toList());
    }
  }

  void scanStream({String? deviceId}) {
    loggerExtension("searchDevice??????????????????????????????? $deviceId ");
    // FlutterBluePlus.stopScan();
    _bluetoothStateStreamController.add(BluetoothStatusEnum.searching);
    for (BluetoothDevice device in FlutterBluePlus.connectedDevices) {
      _addDeviceToList(device);
    }

    _scanResultsSubscription = FlutterBluePlus.scanResults.listen(
      (List<ScanResult> results) async {
        for (ScanResult result in results) {
          loggerExtension(result);

          ///TODO:set deviceID
          _addDeviceToList(result.device);

          if (result.advertisementData.advName == deviceId) {
            loggerExtension(
              "searchDevice/////////////////////////////// $deviceId ",
            );
            searchDevice = result.device;
            await FlutterBluePlus.stopScan();
            _bluetoothStateStreamController
                .add(BluetoothStatusEnum.foundDevice);
            _scanResultsSubscription.cancel();
          }
        }
      },
    );
    scanBluetoothDevices();
  }

  Future<void> scanBluetoothDevices() async {
    bool check = await AppPermissionUtils().checkAll(() {
      scanBluetoothDevices();
    });
    if (check) {
      await FlutterBluePlus.stopScan();
      isSearching.value = true;
      await FlutterBluePlus.startScan(
        timeout: const Duration(
          seconds: AppSettings.scanDelay,
        ),
      );
      await FlutterBluePlus.isScanning
          .where(
            (val) => val == false,
          )
          .first;
      _stopScanTimer();
    }
  }

  Future<void> _stopScanTimer() async {
    if (isSearching.value && searchDevice == null) {
      _bluetoothStateStreamController
          .add(BluetoothStatusEnum.failedToFindDevice);
      isSearching.value = false;
    }
    await FlutterBluePlus.stopScan();
  }

  @override
  connectWithDevice({
    BluetoothDevice? deviceToConnect,
    isReconnecting = false,
  }) async {
    isSearching.value = false;
    _bluetoothStateStreamController.add(BluetoothStatusEnum.connecting);

    BluetoothDevice temDevice = deviceToConnect ?? searchDevice ?? device;

    await temDevice
        .connect(
          timeout: const Duration(
            seconds: AppSettings.scanDelay,
          ),
        )
        .whenComplete(
          () {
            device = temDevice;
            searchDevice = null;
            _bluetoothStateStreamController.add(BluetoothStatusEnum.connected);

            _bleStatusStreamSubscription = device.connectionState.listen(
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
                  if (readStreamSubscription != null) {
                    readStreamSubscription!.cancel();
                  }

                  bool isAllValid = await _checkBluetoothRequirements();

                  if (isAllValid) {
                    _bluetoothStateStreamController
                        .add(BluetoothStatusEnum.disconnect);
                  }
                }
              },
            );
          },
        )
        .timeout(
            const Duration(
              seconds: AppSettings.scanDelay - 1,
            ),
            onTimeout: _failedToConnect)
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
          }
        }
      }
    }
  }

  _receiveMessage() async {
    readStreamSubscription = readCharacteristic!.lastValueStream.listen(
      (value) {
        if (kDebugMode) {
          print(value);
        }
        if (value.isNotEmpty) {
          if (!isReceiving) {
            isReceiving = true;

            ///TODO changeDashboardState.add(AppStatusEnum.loading);
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
      print(' Message length:${range.length}');
      loggerExtension(_dataParser(range));
      messageFromBle = _dataParser(range).split(':').last.trim();
      _completer?.complete();
    }
  }

  Future<FinalResult> write(
    List<int> x, {
    WriteType type = WriteType.message,
  }) async {
    if (kDebugMode) {
      print(x);
    }
    if (type == WriteType.message) {
      loggerExtension(_dataParser(x));
    }

    if (AppSettings.isSkipped) {
      showDialog(
        context: AppSettings.navigatorKey.currentContext!,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text("Connection Error"),
            content: const Text(
              "Please connect with Muzziball and try again",
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(AppStrings.cancel.t()),
                onPressed: () async {
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          );
        },
      );
      return FinalResult(
        responseData: ResponseData(data: "success"),
      );
    }
    bool isAllValid = await _checkBluetoothRequirements();
    if (isAllValid) {
      try {
        for (int i = 0; i < x.length; i = i + AppSettings.fileSendBytesSize) {
          List<int> writeMessage = x.sublist(
            i,
            i + AppSettings.fileSendBytesSize > x.length
                ? x.length
                : i + AppSettings.fileSendBytesSize,
          );

          await Future.delayed(
            const Duration(milliseconds: 100),
          );
          if (kDebugMode) {
            print(writeMessage);
          }
          if (type == WriteType.message) {
            await writeCharacteristic?.write(writeMessage).onError(
                  (error, stackTrace) => throw Exception(error),
                );
          } else if (type == WriteType.wifiPassword) {
            _completer = Completer();
            _timer = Timer(const Duration(seconds: 60), () async {
              if (!(_completer?.isCompleted ?? true)) {
                _completer?.complete();
              }
            });
            await _completer?.future;
            loggerExtension("messageFromBle:$messageFromBle");
            if (messageFromBle.isNotEmpty) {
              return FinalResult(
                responseData: ResponseData(
                  data: messageFromBle,
                ),
              );
            }
          }
        }
      } on Exception catch (_, e) {
        loggerExtension(e);
        return FinalResult(
          error: BaseError(
            code: 605,
            errorType: ErrorType.hardwareDisconnected,
          ),
        );
      }
    }
    return FinalResult(
      responseData: ResponseData(
        data: "success",
      ),
    );
  }

  @override
  disconnect() {
    device.disconnect();
  }

  @override
  reconnect() {
    // _initBluetooth();
    _bluetoothStateStreamController.add(BluetoothStatusEnum.enable);
    device.disconnect();
    connectWithDevice(
      deviceToConnect: device,
      isReconnecting: true,
    );
  }

  @override
  sendSetting() {
    // _handleSendingSettingsMessage(setting);
  }

  @override
  startScan({String? deviceId}) {
    scanStream(deviceId: deviceId);
  }

  @override
  Sink get changeBluetoothState => _bluetoothStateStreamController.sink;

  @override
  Sink get changeDashboardState => _dashboardStateStreamController.sink;

  @override
  Sink get addBluetoothDevice => _blueDevicesStreamController.sink;

  @override
  Sink get addConnectingDevice => _connectingDeviceStreamController.sink;

  //output

  @override
  Stream<BluetoothStatusEnum> get outBluetoothState =>
      _bluetoothStateStreamController.stream
          .map((bluetoothState) => bluetoothState);

  @override
  Stream<AppStatusEnum> get outDashboardState =>
      _dashboardStateStreamController.stream.map((state) => state);

  @override
  Stream<List<BluetoothDevice>> get outBluetoothDevices =>
      _blueDevicesStreamController.stream.map((device) => device);

  @override
  Stream<BluetoothDevice> get outConnectingDevice =>
      _connectingDeviceStreamController.stream.map((device) => device);

  //Functions

  double _getDoubleValue(List<int> values) {
    if (values.length == 4) {
      final bytes = Uint8List.fromList(values);
      final byteData = ByteData.sublistView(bytes);
      double value = byteData.getFloat32(0, Endian.little);
      return double.parse(value.toStringAsFixed(2));
    }
    return 0.0;
  }

  int _getInt32Value(List<int> values) {
    if (values.length == 4) {
      final bytes = Uint8List.fromList(values);
      final byteData = ByteData.sublistView(bytes);
      int value = byteData.getInt32(0, Endian.little);
      return value;
    }
    return 0;
  }

  int _getInt16Value(List<int> values) {
    if (values.length == 2) {
      final bytes = Uint8List.fromList(values);
      final byteData = ByteData.sublistView(bytes);
      int value = byteData.getInt16(0, Endian.little);
      return value;
    }
    return 0;
  }

  List<int> _setInt16Value(int value) {
    ByteBuffer buffer = Uint16List.fromList([value]).buffer;
    return Uint8List.view(buffer);
  }

  List<int> _doubleToListInt(double value) {
    ByteData bytes = ByteData(4);
    bytes.setFloat32(0, value, Endian.little);

    List<int> response = bytes.buffer.asInt8List().toList();

    return response;
  }

  String _dataParser(List<int> dataFromDevice) {
    return utf8.decode(dataFromDevice);
  }
}

mixin AppConnectServicesInputs {
  connectWithDevice({
    BluetoothDevice? deviceToConnect,
    isReconnecting = false,
  });

  disconnect();

  reconnect();

  startScan({String? deviceId});

  sendSetting();

  Sink get changeBluetoothState;

  Sink get changeDashboardState;

  Sink get addBluetoothDevice;

  Sink get addConnectingDevice;
}

mixin AppConnectServicesOutputs {
  Stream<BluetoothStatusEnum> get outBluetoothState;

  Stream<BluetoothDevice> get outConnectingDevice;

  Stream<AppStatusEnum> get outDashboardState;

  Stream<List<BluetoothDevice>> get outBluetoothDevices;
}
