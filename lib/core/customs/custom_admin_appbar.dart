// Custom App Bar Widget
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rakli_salons_app/core/theme/theme_constants.dart';
import 'package:rakli_salons_app/core/utils/assets.dart';

class CustomAdminAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onMenuPressed;

  const CustomAdminAppBar({
    super.key,
    required this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF8B1818),
      leading: IconButton(
        icon: const Icon(Icons.menu, color: kSecondaryColor),
        onPressed: onMenuPressed,
      ),
      actions: [
        Container(
          padding: EdgeInsets.all(8),
          child: SvgPicture.asset(
            Assets.assetsImagesCart,
            width: 34,
            height: 34,
            colorFilter: ColorFilter.mode(kSecondaryColor, BlendMode.srcIn),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.notifications, color: kSecondaryColor),
          onPressed: () {},
          iconSize: 34,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
