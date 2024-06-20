import 'package:flutter/cupertino.dart';

import '../theme/theme_color.dart';

class PopupCustom {
  static void showPopup(BuildContext context, {String? textContent,String? title, String? textDisable, String? textEnable, Widget? content, required Function() function}) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title ?? "Message"),
        content: content ??  Text(textContent ?? ''),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context),
            child: Text(textDisable ?? "No", style: const TextStyle(color: ThemeColor.redColor)),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text(textEnable ?? 'Yes', style: const TextStyle(color: ThemeColor.blueColor, fontWeight: FontWeight.bold)),
            onPressed: () async {
              Navigator.pop(context);
              function();
            },
          ),
        ],
      ),
    );
  }
}