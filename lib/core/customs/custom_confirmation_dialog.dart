import 'package:flutter/material.dart';
import 'package:rakli_salons_app/core/customs/custom_button.dart';
import 'package:rakli_salons_app/core/theme/theme_constants.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';

class CustomConfirmationDialog extends StatelessWidget {
  const CustomConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    required this.confirmButtonText,
    required this.onConfirm,
    required this.onCancel,
    this.icon = Icons.warning_amber_outlined,
  });

  final String title;
  final String message;
  final String confirmButtonText;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: kPrimaryColor,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            CircleAvatar(
              radius: 32,
              backgroundColor: Colors.teal,
              child: Icon(
                icon,
                size: 32,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            // Title
            Text(
              title,
              style: AppStyles.bold20.copyWith(color: kSecondaryColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            // Message
            Text(
              message,
              style: AppStyles.regular15.copyWith(color: kSecondaryColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            // Confirm Button
            CustomButton(
              hpadding: 82,
              title: FittedBox(
                child: Text(
                  confirmButtonText,
                  style: AppStyles.bold16.copyWith(color: Colors.black),
                ),
              ),
              onPressed: onConfirm,
              color: kSecondaryColor,
              minwidth: double.infinity,
            ),
            const SizedBox(height: 2),
            // Cancel Button
            TextButton(
              onPressed: onCancel,
              child: Text(
                "Cancel",
                style: AppStyles.bold16.copyWith(color: kSecondaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showCustomConfirmationDialog({
  required BuildContext context,
  required String title,
  required String message,
  required String confirmButtonText,
  required VoidCallback onConfirm,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomConfirmationDialog(
        title: title,
        message: message,
        confirmButtonText: confirmButtonText,
        onConfirm: onConfirm,
        onCancel: () => Navigator.pop(context),
      );
    },
  );
}
