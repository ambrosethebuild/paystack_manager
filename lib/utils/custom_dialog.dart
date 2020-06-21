// ignore_for_file: const_initialized_with_non_constant_value, non_constant_identifier_names
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialog {
  static dismissDialog(context) {
    try {
      Navigator.of(context, rootNavigator: true).pop();
    } catch (error) {
      print("Error Dismissing Dialog ==> $error");
    }
  }

  //Show dialog
  static showAlertDialog(
    BuildContext context, {
    String title = "",
    String message = "",
    bool isDismissible = true,
    Function onDismissAction,
  }) async {
    Widget alertBodyWidget = Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        (Platform.isIOS)
            ? CupertinoActivityIndicator()
            : CircularProgressIndicator(),
        (Platform.isIOS) ? SizedBox(height: 10) : SizedBox.shrink(),
        Text(title),
        (Platform.isIOS) ? SizedBox(height: 10) : SizedBox.shrink(),
        Text(message),
        (Platform.isIOS) ? SizedBox(height: 10) : SizedBox.shrink(),
      ],
    );

    var alert;

    // set up the AlertDialog
    if (Platform.isAndroid) {
      alert = AlertDialog(
        content: Container(
          child: alertBodyWidget,
        ),
      );
    } else {
      alert = CupertinoAlertDialog(
        content: alertBodyWidget,
      );
    }

    // show the dialog
    if (context != null) {
      showDialog(
        context: context,
        barrierDismissible: isDismissible,
        builder: (BuildContext context) {
          return alert;
        },
      ).then(
        (val) {
          if (onDismissAction != null) {
            onDismissAction();
          }
        },
      );
    }
  }
}
