import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:herbarium_mobile/src/core/utils/app_theme.dart';

class SetupWifiGreenhouseStep extends StatefulWidget {
  final Function(String, String) onTapNext;

  const SetupWifiGreenhouseStep({Key? key, required this.onTapNext})
      : super(key: key);

  @override
  State<SetupWifiGreenhouseStep> createState() =>
      _SetupWifiGreenhouseStepState();
}

class _SetupWifiGreenhouseStepState extends State<SetupWifiGreenhouseStep> {
  late TextEditingController _controllerSsid;
  late TextEditingController _controllerPassword;

  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _controllerSsid = TextEditingController();
    _controllerPassword = TextEditingController();
  }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          Text(AppLocalizations.of(context)!.setup_device_set_wifi,
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: Colors.white)),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          // const Spacer(),
          TextField(
            decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppTheme.gray)),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppTheme.leafGreen)),
                errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red)),
                focusedErrorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red)),
                hintText: AppLocalizations.of(context)!
                    .setup_device_set_wifi_ssid_placeholder),
            controller: _controllerSsid,
            onChanged: (value) {
              if (value.isEmpty) {
                setState(() {
                  _isValid = false;
                });
              } else {
                setState(() {
                  _isValid = true;
                });
              }
            },
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppTheme.gray)),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppTheme.leafGreen)),
                errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red)),
                focusedErrorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red)),
                label: Text(AppLocalizations.of(context)!
                    .setup_device_set_wifi_password_placeholder),
                hintText: AppLocalizations.of(context)!
                    .setup_device_set_wifi_password_placeholder),
            controller: _controllerPassword,
            obscureText: true,
            onChanged: (value) {
              setState(() {
                _isValid = _controllerSsid.text.isNotEmpty &&
                    _controllerPassword.text.isNotEmpty;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0, 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: _isValid
                        ? () => widget.onTapNext(
                            _controllerSsid.text, _controllerPassword.text)
                        : null,
                    child:
                        Text(AppLocalizations.of(context)!.next.toUpperCase()))
              ],
            ),
          ),
          const Spacer(flex: 2),
        ],
      );
}
