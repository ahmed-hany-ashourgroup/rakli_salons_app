import 'package:flutter/material.dart';
import 'package:rakli_salons_app/core/theme/theme_constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.borderRadius = 30,
    this.minwidth = 200,
    this.minheight = 60,
    this.vpadding = 15,
    this.hpadding = 40,
    this.color = kPrimaryColor,
  });
  final Widget title;
  final VoidCallback onPressed;
  final double borderRadius, minwidth, minheight, vpadding, hpadding;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        maximumSize: WidgetStatePropertyAll(Size(
          minwidth,
          minheight,
        )),
        backgroundColor: WidgetStateProperty.all(
          color,
        ),
        padding: WidgetStateProperty.all(
            EdgeInsets.symmetric(horizontal: hpadding, vertical: vpadding)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
      child: title,
    );
  }
}
