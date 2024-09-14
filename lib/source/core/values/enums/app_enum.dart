enum ProgramType {
  all,
  focus,
  play,
  mindfulness,
  interactiveAudio,
  music,
}

enum ProgramMode {
  dynamic,
  kick,
  continuous,
  dynamicWithKick,
  continuousWithKick,
  dynamicWithContinuous
}

enum BluetoothStatusEnum {
  connected,
  connecting,
  disconnect,
  disable,
  enable,
  searching,
  failedToConnect,
  failedToFindDevice,
  foundDevice,
  alreadyConnected,
  enableLocation,
  needBluetoothPermission,
  needLocationPermission,
}

enum AppStatusEnum {
  empty,
  loading,
  loaded,
}

enum ConnectionDataState {
  initial,
  loading,
  success,
  empty,
  failure,
  idLoading,
  uploading,
  uploaded,
  idSuccess,
  idFailure
}

enum ProgramDataState {
  initial,
  loading,
  success,
  empty,
  failure,
  programSelected,
  musicFromMobileLoaded,
  fileSentPercentage,
  fileUploadedSuccessfully,
}

enum AudioState {
  initial,
  loading,
  success,
  failure,
  empty,
}

enum WriteType {
  file,
  message,
  getMuzziballData,
  wifiName,
  wifiPassword,
}
