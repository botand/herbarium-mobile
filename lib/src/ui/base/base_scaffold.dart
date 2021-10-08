import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:herbarium_mobile/src/core/utils/app_theme.dart';

class BaseScaffold extends StatefulWidget {
  const BaseScaffold({Key? key, this.appBar, required this.body, this.fab, this.fabLocation}) : super(key: key);

  final AppBar? appBar;

  final Widget body;

  final FloatingActionButton? fab;

  final FloatingActionButtonLocation? fabLocation;

  @override
  State<BaseScaffold> createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {

  @override
  void initState() {
    super.initState();

    if(Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          systemNavigationBarColor: AppTheme.purple
      ));
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: widget.appBar,
    body: SafeArea(
      child: widget.body,
    ),
    floatingActionButton: widget.fab,
    floatingActionButtonLocation: widget.fabLocation,
  );
}