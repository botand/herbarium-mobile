import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class BleServicesUuids {
  static Uuid get deviceIdentity =>
      Uuid.parse('0000180A-0000-1000-8000-00805f9b34fb');

  static Uuid get setupDevice =>
      Uuid.parse('f08a607d-bb1f-4fd3-adb1-2c3d580c6d0c');
}

class BleCharacteristicsUuids {
  static Uuid get deviceIdentity =>
      Uuid.parse('00002a25-0000-1000-8000-00805f9b34fb');
  static Uuid get connectionStatus =>
      Uuid.parse('47f46eb3-0777-48ba-9c2b-66303b21a167');
  static Uuid get setupWifi =>
      Uuid.parse('ddb4c99c-d127-4314-bb6f-597c4cb1859d');
}
