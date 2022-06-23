import 'package:flutter/material.dart';

import '../styles/app_colors.dart';

class UIHelper {
  static Future gotoScreen(BuildContext context, Widget toScreen,
      {bool? removePreviousStack}) {
    if (removePreviousStack == null || removePreviousStack == false) {
      return Navigator.push(
          context, MaterialPageRoute(builder: (context) => toScreen));
    } else {
      return gotoScreenForced(context, toScreen);
    }
  }

  static Future<void> showAlertDialog(BuildContext context, String msg) async {
    // Create button
    Widget okButton = FlatButton(
      child: Text(
        "OK",
        style: TextStyle(color: AppColors.primaryColor),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text(msg),
      title: const Text('Message'),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static Future gotoScreenForced(BuildContext context, Widget toScreen) {
    return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => toScreen,
      ),
      (route) => false,
    );
  }
}
