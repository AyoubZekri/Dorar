import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:get/get.dart';

Flushbar? _currentFlushbar;

void showSnackbar(String titleKey, String messageKey, Color color) {
  final context = Get.context;
  if (context == null) return;

  // إزالة أي Flushbar حالية
  _currentFlushbar?.dismiss();
  _currentFlushbar = null;

  IconData iconData;
  if (color == Colors.red || color == Colors.redAccent) {
    iconData = Icons.error_outline;
  } else if (color == Colors.orange) {
    iconData = Icons.warning_amber_rounded;
  } else if (titleKey.contains('مفضل')) {
    iconData = Icons.bookmark_added_rounded;
  } else {
    iconData = Icons.check_circle_outline;
  }

  WidgetsBinding.instance.addPostFrameCallback((_) {
    _currentFlushbar = Flushbar(
      margin: const EdgeInsets.all(15),
      borderRadius: BorderRadius.circular(15),
      backgroundColor: color,
      icon: Icon(iconData, color: Colors.white, size: 28),
      titleText: Text(
        titleKey,
        style: const TextStyle(
          fontFamily: 'Cairo',
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      messageText: Text(
        messageKey,
        style: const TextStyle(
          fontFamily: 'Cairo',
          color: Colors.white,
          fontSize: 14,
        ),
      ),
      duration: const Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.BOTTOM,
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutCirc,
      reverseAnimationCurve: Curves.easeInCirc,
    )..show(context).then((_) {
        _currentFlushbar = null; // إعادة تعيين بعد الإغلاق
      });
  });
}
