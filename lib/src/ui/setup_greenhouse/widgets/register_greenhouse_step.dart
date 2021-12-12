import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:herbarium_mobile/src/core/utils/app_theme.dart';

class RegisterGreenhouseStep extends StatefulWidget {
  final Function(String) onTapNext;

  const RegisterGreenhouseStep({Key? key, required this.onTapNext})
      : super(key: key);

  @override
  State<RegisterGreenhouseStep> createState() => _RegisterGreenhouseStepState();
}

class _RegisterGreenhouseStepState extends State<RegisterGreenhouseStep> {
  late TextEditingController _controller;

  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          Text(AppLocalizations.of(context)!.setup_device_set_name_title,
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
                    .setup_device_set_name_placeholder),
            controller: _controller,
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
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0, 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: _isValid
                        ? () => widget.onTapNext(_controller.text)
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
