import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:herbarium_mobile/src/core/utils/app_theme.dart';
import 'package:herbarium_mobile/src/ui/base/bottom_bar.dart';

class BaseScaffold extends StatefulWidget {
  const BaseScaffold(
      {Key? key,
      this.appBar,
      required this.body,
      bool isLoading = false,
      bool isInteractionLimitedWhileLoading = false,
      bool showBottomBar = true,
      this.fab,
      this.fabLocation})
      : _isLoading = isLoading,
        _isInteractionLimitedWhileLoading = isInteractionLimitedWhileLoading,
        _showBottomBar = showBottomBar,
        super(key: key);

  final AppBar? appBar;

  final Widget body;

  final bool _isLoading;

  final bool _isInteractionLimitedWhileLoading;

  final bool _showBottomBar;

  final FloatingActionButton? fab;

  final FloatingActionButtonLocation? fabLocation;

  @override
  State<BaseScaffold> createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          systemNavigationBarColor: AppTheme.purple));
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: widget.appBar,
        body: SafeArea(
          child: Stack(children: [
            widget.body,
            if (widget._isLoading)
              _buildLoading(
                  isInteractionLimitedWhileLoading:
                      widget._isInteractionLimitedWhileLoading)
          ]),
        ),
        floatingActionButton: widget.fab,
        floatingActionButtonLocation: widget.fabLocation,
        bottomNavigationBar: widget._showBottomBar ? BottomBar() : null,
      );

  Widget _buildLoading({bool isInteractionLimitedWhileLoading = false}) =>
      Stack(
        children: [
          if (isInteractionLimitedWhileLoading)
            const Opacity(
              opacity: 0.5,
              child: ModalBarrier(dismissible: false, color: Colors.grey),
            ),
          const Center(child: CircularProgressIndicator())
        ],
      );
}
