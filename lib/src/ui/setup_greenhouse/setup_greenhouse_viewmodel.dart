import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:herbarium_mobile/src/core/constants/navigation_route.dart';
import 'package:herbarium_mobile/src/core/repositories/greenhouses_repository.dart';
import 'package:herbarium_mobile/src/core/services/navigation_service.dart';
import 'package:herbarium_mobile/src/ui/setup_greenhouse/ble_uuids.dart';
import 'package:herbarium_mobile/src/core/locator.dart';
import 'package:herbarium_mobile/src/ui/setup_greenhouse/service/bluetooth_service.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

class SetupGreenHouseViewModel extends ReactiveViewModel {
  final _devicesName = 'Herbarium-greenhouse';

  final BluetoothService _bluetoothService = locator<BluetoothService>();

  final GreenhousesRepository _greenhousesRepository =
      locator<GreenhousesRepository>();

  final NavigationService _navigationService = locator<NavigationService>();

  final AppLocalizations intl;

  final Logger _logger = locator<Logger>();

  List<DiscoveredDevice> get _devices => _bluetoothService.devices
      .where((e) => e.name.startsWith(_devicesName))
      .toList();

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_bluetoothService];

  SetupGreenhouseStep _currentStep = SetupGreenhouseStep.search;

  SetupGreenhouseStep get currentStep => _currentStep;

  DiscoveredDevice? _deviceConnected;

  String? _newGreenhouseName;

  String? _newGreenhouseUuid;

  SetupGreenHouseViewModel({required this.intl}) {
    _greenhousesRepository.getGreenhouses();
  }

  /// Start scanning for BLE devices
  void startScan() {
    _bluetoothService.startScan();
    _bluetoothService.addListener(() async {
      final devices = _devices;

      for (final device in devices) {
        _bluetoothService.connectTo(device);
        _newGreenhouseUuid = String.fromCharCodes(
            await _bluetoothService.readData(
                device,
                BleServicesUuids.deviceIdentity,
                BleCharacteristicsUuids.deviceIdentity));
        _logger.d("Device with UUID $_newGreenhouseUuid found.");

        final greenhouseIndex = _greenhousesRepository.greenhouses
            .indexWhere((element) => element.uuid == _newGreenhouseUuid);
        if (greenhouseIndex == -1) {
          _deviceConnected = device;
          _toStep(SetupGreenhouseStep.register);
        }
      }
    });
  }

  /// Stop scanning for BLE devices
  void stopScan() {
    _bluetoothService.stopScan();
  }

  void _toStep(SetupGreenhouseStep step) {
    _logger.d("$runtimeType - moving to step: $step");
    _currentStep = step;
    notifyListeners();
  }

  Future<void> registerGreenhouse(String name) async {
    _newGreenhouseName = name;
    setBusy(true);
    final result = await _greenhousesRepository.registerGreenhouse(
        _newGreenhouseUuid!, _newGreenhouseName!);

    if (result) {
      _toStep(SetupGreenhouseStep.done);
    } else {
      Fluttertoast.showToast(msg: intl.basic_error);
    }
    setBusy(false);
  }

  /// Handle the WIFI connection
  Future setupWifi(String ssid, String password) async {
    await _bluetoothService.sendData(
        _deviceConnected!,
        BleServicesUuids.setupDevice,
        BleCharacteristicsUuids.setupWifi,
        ssid.codeUnits);
    await _bluetoothService.sendData(
        _deviceConnected!,
        BleServicesUuids.setupDevice,
        BleCharacteristicsUuids.setupWifi,
        password.codeUnits);
    _toStep(SetupGreenhouseStep.done);
  }

  /// Handle navigation and validation onto the next step.
  void next() {
    if (_currentStep == SetupGreenhouseStep.done) {
      _navigationService.pushNamedAndRemoveUntil(
          path: NavigationRoute.home,
          removeUntilRouteNamed: NavigationRoute.home);
      return;
    }
  }
}

enum SetupGreenhouseStep { search, setupWifi, register, done }
