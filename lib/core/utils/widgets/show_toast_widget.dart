import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastStates { success, error, warning, info }

showToast({
  required String msg,
  required ToastStates state,
  ToastGravity gravity = ToastGravity.TOP,
  Toast toastLength = Toast.LENGTH_LONG,
}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: toastLength,
    gravity: gravity,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

Color chooseToastColor(ToastStates states) {
  switch (states) {
    case ToastStates.success:
      return Colors.green;
    case ToastStates.error:
      return Colors.red;
    case ToastStates.warning:
      return Colors.amber;
    case ToastStates.info:
      return Colors.blue;
  }
}
