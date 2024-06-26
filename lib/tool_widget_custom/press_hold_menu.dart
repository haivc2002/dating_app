import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PressHoldMenu extends StatelessWidget {
  final double width, height;
  final Widget content;
  final List<String> listTitle;
  final List<Function()> listFunction;
  const PressHoldMenu({
    Key? key,
    required this.width,
    required this.height,
    required this.content,
    required this.listTitle,
    required this.listFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoContextMenu.builder(
      actions: List.generate(listTitle.length, (index) {
        return CupertinoContextMenuAction(
          child: Text(listTitle[index]),
          onPressed: () {
            Navigator.pop(context);
            listFunction[index]();
          },
        );
      }),
      builder: (context, animation) => SizedBox(
        height: height,
        width: width,
        child: Material(
          color: Colors.transparent,
          child: content,
        )
      ),
    );
  }

}
