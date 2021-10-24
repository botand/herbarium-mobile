import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:herbarium_mobile/src/ui/setup_greenhouse/ble_uuids.dart';
import 'package:herbarium_mobile/src/core/locator.dart';
import 'package:herbarium_mobile/src/ui/setup_greenhouse/service/bluetooth_service.dart';
import 'package:stacked/stacked.dart';

class SetupGreenHouseViewModel extends ReactiveViewModel {
  final _devicesName = 'Herbarium-greenhouse';

  final _bluetoothService = locator<BluetoothService>();

  List<DiscoveredDevice> get _devices => _bluetoothService.devices
      .where((e) => e.name.startsWith(_devicesName))
      .toList();

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_bluetoothService];

  /// Start scanning for BLE devices
  void startScan() {
    _bluetoothService.startScan();
    _bluetoothService.addListener(() async {
      final devices = _devices;
      if (devices.length == 1) {
        _bluetoothService.stopScan();
        _bluetoothService.connectTo(devices.first);
        print(await _bluetoothService.readData(
            devices.first,
            BleServicesUuids.deviceIdentity,
            BleCharacteristicsUuids.deviceIdentity));
      }
    });
  }

  /// Stop scanning for BLE devices
  void stopScan() {
    _bluetoothService.stopScan();
  }
}
