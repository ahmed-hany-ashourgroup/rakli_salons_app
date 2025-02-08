// Custom App Bar Widget
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rakli_salons_app/core/theme/theme_constants.dart';
import 'package:rakli_salons_app/core/utils/app_router.dart';
import 'package:rakli_salons_app/features/home/manager/get_notifications_cubit/get_notifications_cubit.dart';

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
        IconButton(
          icon: const Icon(Icons.notifications, color: kSecondaryColor),
          onPressed: () {
            // Fetch notifications before navigating
            context.read<GetNotificationsCubit>().getNotifications();
            GoRouter.of(context).push(AppRouter.kNotificationsView);
          },
          iconSize: 34,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
