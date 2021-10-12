import 'package:flutter/material.dart';
import 'package:herbarium_mobile/src/ui/base/base_scaffold.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) =>
      const BaseScaffold(body: Center(child: Text("Home")));
}
