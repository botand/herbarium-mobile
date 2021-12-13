import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:herbarium_mobile/src/core/services/analytics_service.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';

import '../../../core/locator.dart';

class BluetoothService with ReactiveServiceMixin {
  /// Service used to interact with BLE
  final _flutterReactiveBle = FlutterReactiveBle();

  final _logger = locator<Logger>();

  final _analyticsService = locator<AnalyticsService>();

  final _deviceConnectionController = StreamController<ConnectionStateUpdate>();

  StreamSubscription<ConnectionStateUpdate>? _connection;

  StreamSubscription<DiscoveredDevice>? _subscription;

  /// List of devices discovered
  final _devices = ReactiveList<DiscoveredDevice>();

  List<DiscoveredDevice> get devices => _devices;

  BluetoothService() {
    listenToReactiveValues([_devices]);
  }

  /// Start scanning for BLE Devices.
  /// When a device is detected, the [devices] list is updated.
  /// Be aware, if you start scanning the existing [devices] list will be clear.
  void startScan({List<Uuid>? serviceIds}) async {
    if (!(await _checkPermissions())) {
      throw Error();
    }
    _devices.clear();
    _subscription?.cancel();
    _subscription = _flutterReactiveBle
        .scanForDevices(withServices: serviceIds ?? [])
        .listen((device) {
      final knowDeviceIndex =
          _devices.indexWhere((element) => element.id == device.id);
      if (knowDeviceIndex >= 0) {
        _devices[knowDeviceIndex] = device;
      } else {
        _devices.add(device);
      }
    }, onError: (Object e, StackTrace stack) {
      _logger.e("BLE - Device scan fails with error: $e");
      _analyticsService.logError(
          runtimeType.toString(), "startScanError", null, stack);
    });
  }

  /// Check if the application has the right permission to use Bluetooth.
  /// Will ask for the permissions if needed.
  Future<bool> _checkPermissions() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      final androidVersion = androidDeviceInfo.version.sdkInt!;

      if (androidVersion >= 31) {
        Map<Permission, PermissionStatus> statuses = await [
          Permission.bluetoothConnect,
          Permission.bluetoothScan
        ].request();

        return (statuses[Permission.bluetoothConnect] ==
                PermissionStatus.granted &&
            statuses[Permission.bluetoothScan] == PermissionStatus.granted);
      } else if (androidVersion >= 23) {
        return await Permission.location.request().isGranted;
      } else {
        return true;
      }
    } else {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      final iosVersion = double.parse(iosDeviceInfo.systemVersion!);

      if (iosVersion >= 13) {
        return await Permission.bluetooth.request().isGranted;
      } else {
        return true;
      }
    }
  }

  /// Stop scanning for BLE devices
  Future<void> stopScan() async {
    await _subscription?.cancel();
  }

  Future<void> connectTo(DiscoveredDevice device) async {
    _connection?.cancel();

    _logger.d(device.serviceUuids);

    _connection = _flutterReactiveBle
        .connectToAdvertisingDevice(
            id: device.id,
            prescanDuration: const Duration(seconds: 5),
            withServices: device.serviceUuids)
        .listen(_deviceConnectionController.add,
            onError: (Object e, StackTrace stack) {
      _logger.e("BLE - Device connection fails with error: $e");
      _analyticsService.logError(
          runtimeType.toString(), "connectToError", null, stack);
    });
  }

  Future<void> sendData(DiscoveredDevice device, Uuid serviceUuid,
      Uuid characteristicUuid, List<int> values) async {
    var characteristic = QualifiedCharacteristic(
        serviceId: serviceUuid,
        characteristicId: characteristicUuid,
        deviceId: device.id);
    await _flutterReactiveBle.writeCharacteristicWithResponse(characteristic,
        value: values);
  }

  Future<List<int>> readData(DiscoveredDevice device, Uuid serviceUuid,
      Uuid characteristicUuid) async {
    var characteristic = QualifiedCharacteristic(
        serviceId: serviceUuid,
        characteristicId: characteristicUuid,
        deviceId: device.id);

    return await _flutterReactiveBle.readCharacteristic(characteristic);
  }

  Stream<List<int>> subscribeToCharacteristic(
      DiscoveredDevice device, Uuid serviceUuid, Uuid characteristicUuid) {
    var characteristic = QualifiedCharacteristic(
        serviceId: serviceUuid,
        characteristicId: characteristicUuid,
        deviceId: device.id);

    return _flutterReactiveBle.subscribeToCharacteristic(characteristic);
  }

  Future<void> dispose() async {
    await _subscription?.cancel();
    await _connection?.cancel();
  }
}
