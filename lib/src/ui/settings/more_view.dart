import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:herbarium_mobile/src/ui/base/base_scaffold.dart';
import 'package:herbarium_mobile/src/ui/settings/more_viewmodel.dart';
import 'package:stacked/stacked.dart';

class MoreView extends StatelessWidget {
  const MoreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ViewModelBuilder.nonReactive(
        viewModelBuilder: () => MoreViewModel(),
        builder: (context, MoreViewModel viewModel, child) => BaseScaffold(
            appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text(AppLocalizations.of(context)!.title_more)),
            body: ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.logout_outlined),
                  title: Text(AppLocalizations.of(context)!.more_sign_out),
                  onTap: () => showDialog(
                      context: context,
                      builder: (context) =>
                          _buildSignOutDialog(context, viewModel)),
                ),
                ListTile(
                  leading: const Icon(Icons.search_outlined),
                  title:
                      Text(AppLocalizations.of(context)!.setup_device_search),
                  onTap: viewModel.searchNewDevice,
                )
              ],
            )),
      );

  Widget _buildSignOutDialog(BuildContext context, MoreViewModel viewModel) =>
      AlertDialog(
          content: Text(AppLocalizations.of(context)!.more_confirm_sign_out),
          actions: [
            TextButton(
                onPressed: () => viewModel.signOut(),
                child: Text(AppLocalizations.of(context)!.yes,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.white))),
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(AppLocalizations.of(context)!.no,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.white))),
          ]);
}
