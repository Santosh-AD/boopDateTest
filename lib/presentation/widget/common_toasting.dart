import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

//This is common Toast View
showToast(BuildContext context, {required String message, String title: 'Error'}) {
  Flushbar(
    title: title,
    message: message,
    duration: Duration(seconds: 2),
    flushbarPosition: FlushbarPosition.TOP,
    margin: EdgeInsets.symmetric(horizontal: 8),
    borderRadius: BorderRadius.circular(8),
    backgroundColor: Colors.blue,
    blockBackgroundInteraction: false,
  ).show(context);
}
