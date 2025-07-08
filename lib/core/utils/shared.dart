import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:weather_app/core/export.dart';


void printDebug(String message) {
  if (kDebugMode) debugPrint(message);
}

enum ToastedStates { success, error, warning, info }

Widget worningToast(String message) {
  final Widget toast = Container(
    padding: EdgeInsets.symmetric(horizontal: 25.0.w, vertical: 20.0.h),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.r),
      color: Colors.transparent.withOpacity(0.75),
    ),
    child: Text(message, style: const TextStyle(color: Colors.white)),
  );

  return toast;
}


void showLoadingDialog(BuildContext context) {
  showDialog(
    barrierColor: Colors.transparent,
    context: context,
    builder: (context) => PopScope(
      canPop: false,
      child: ModalProgressHUD(
        inAsyncCall: true,
        progressIndicator: Lottie.asset(
          'assets/animations/loading.json',
          fit: BoxFit.cover,
          width: 100.w,
        ),
        color: AppColor.primaryColor,
        blur: 1,
        child: const SizedBox(),
      ),
    ),
  );
}
