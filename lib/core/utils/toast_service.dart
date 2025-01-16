// toast_service.dart

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastType { success, error, info, warning }

class ToastService {
  /// Displays a custom toast with an icon based on the [type].
  ///
  /// [message] is the text to display.
  /// [type] determines the icon and background color.
  static void showCustomToast({
    required String message,
    ToastType type = ToastType.info,
  }) {
    Color backgroundColor;
    String icon;

    // Assign icon and background color based on the toast type
    switch (type) {
      case ToastType.success:
        backgroundColor = Colors.green;
        icon = "✅"; // Checkmark emoji
        break;
      case ToastType.error:
        backgroundColor = Colors.red;
        icon = "❌"; // Cross mark emoji
        break;
      case ToastType.warning:
        backgroundColor = Colors.orange;
        icon = "⚠️"; // Warning emoji
        break;
      case ToastType.info:
        backgroundColor = Colors.blue;
        icon = "ℹ️"; // Information emoji
    }

    // Display the toast
    Fluttertoast.showToast(
      msg: "$icon $message", // Combine icon and message
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 16.0,
      // Optionally, you can add padding and other customization
    );
  }
}
