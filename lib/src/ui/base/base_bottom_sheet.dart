import 'package:flutter/material.dart';

class BaseBottomSheet extends StatelessWidget {
  final Widget? title;

  final Widget child;

  final bool showHandle;

  const BaseBottomSheet(
      {Key? key, this.title, required this.child, this.showHandle = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Column(
        children: [
          if (showHandle)
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 12.0),
                child: Container(
                  height: 5,
                  width: 50,
                  decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                ),
              ),
            ),
          if(title != null)
            Padding(padding: const EdgeInsets.all(8.0), child: title),
          const Divider(thickness: 1.5),
          Expanded(
            child: child,
          )
        ],
      );
}
