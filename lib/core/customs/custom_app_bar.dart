import 'package:flutter/material.dart';
import 'package:rakli_salons_app/core/theme/theme_constants.dart';
import 'package:rakli_salons_app/core/utils/logger.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    this.title = const Text(''),
    required this.icon,
    this.backButtonColor = kSecondaryColor,
  });
  final Widget title, icon;
  final Color backButtonColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: backButtonColor,
            size: 34,
          ),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Logger.info("Can't go back");
            }
          },
        ),
        Spacer(),
        title,
        Spacer(),
        icon,
      ],
    );
  }
}
