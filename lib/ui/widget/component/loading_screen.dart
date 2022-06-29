import 'package:flutter/material.dart';

class LoaderDialog {

  static Future<void> showLoadingDialog(BuildContext context) async {
    var wid = MediaQuery.of(context).size.width / 2;
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child:  Row(
            mainAxisSize: MainAxisSize.min,
            children: [
               CircularProgressIndicator(),
               Text("Loading"),
            ],
          ),
        );
      },
    );
  }
}