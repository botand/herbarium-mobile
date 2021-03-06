import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:herbarium_mobile/src/core/models/greenhouse.dart';
import 'package:herbarium_mobile/src/core/utils/app_theme.dart';
import 'package:herbarium_mobile/src/ui/base/base_bottom_sheet.dart';

class ModifyGreenhouseInfoBottomSheet extends StatefulWidget {
  final Function(String) onSave;

  final Future Function() onDelete;

  final Greenhouse greenhouse;

  const ModifyGreenhouseInfoBottomSheet(
      {Key? key,
      required this.onSave,
      required this.greenhouse,
      required this.onDelete})
      : super(key: key);

  @override
  State<ModifyGreenhouseInfoBottomSheet> createState() =>
      _ModifyGreenhouseInfoBottomSheetState();
}

class _ModifyGreenhouseInfoBottomSheetState
    extends State<ModifyGreenhouseInfoBottomSheet> {
  late TextEditingController _controller;

  bool _isValid = true;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.greenhouse.name);
  }

  @override
  Widget build(BuildContext context) => BaseBottomSheet(
        isLoading: _isLoading,
        title: Text(AppLocalizations.of(context)!.greenhouse_modify_title,
            style: Theme.of(context).textTheme.headline5),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(AppLocalizations.of(context)!.cancel.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: AppTheme.gray))),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: OutlinedButton(
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  await widget.onSave(_controller.text);
                  setState(() {
                    _isLoading = false;
                  });
                },
                child: Text(AppLocalizations.of(context)!.save.toUpperCase())),
          )
        ],
        child: ListView(children: _buildList(context)),
      );

  List<Widget> _buildList(BuildContext context) {
    final List<Widget> list = [];

    list.addAll(_buildNameForm(context));
    list.addAll(_buildDeleteOption(context));

    return list;
  }

  List<Widget> _buildNameForm(BuildContext context) => [
        ListTile(
          title: Text(
            AppLocalizations.of(context)!.greenhouse_modify_name,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          dense: true,
          trailing: IconButton(
            icon: const Icon(Icons.restore_outlined),
            onPressed: () {
              setState(() {
                _controller.text = widget.greenhouse.name;
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
              16.0, 8.0, 16.0, MediaQuery.of(context).viewInsets.bottom),
          child: TextField(
            decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppTheme.gray)),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppTheme.leafGreen)),
                errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red)),
                focusedErrorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red)),
                errorText:
                    !_isValid ? AppLocalizations.of(context)!.required : null),
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
        )
      ];

  List<Widget> _buildDeleteOption(BuildContext context) => [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Divider(thickness: 1.5),
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.delete,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.red)),
          trailing: IconButton(
              icon: const Icon(Icons.delete_outlined),
              onPressed: () => showDialog(
                  barrierDismissible: true,
                  useSafeArea: true,
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text(AppLocalizations.of(context)!
                            .greenhouse_delete_confirm),
                        content:
                            Text(AppLocalizations.of(context)!.irreversible),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child:
                                  Text(AppLocalizations.of(context)!.cancel)),
                          OutlinedButton(
                              onPressed: () async {
                                Navigator.of(context).pop();
                                setState(() {
                                  _isLoading = true;
                                });
                                await widget.onDelete();
                                setState(() {
                                  _isLoading = false;
                                });
                              },
                              child: Text(AppLocalizations.of(context)!.delete))
                        ],
                      ))),
        )
      ];
}
