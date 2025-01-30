import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rakli_salons_app/core/customs/custom_confirmation_dialog.dart';
import 'package:rakli_salons_app/core/utils/app_router.dart';
import 'package:rakli_salons_app/features/auth/manager/log_out_cubit/log_out_cubit.dart';
import 'package:rakli_salons_app/features/auth/manager/user_cubit/user_cubit.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFF8B1818),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: const Color(0xFF8B1818).withOpacity(0.9),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: CachedNetworkImageProvider(
                        SalonsUserCubit.user.photo ?? ''),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    SalonsUserCubit.user.name ?? '',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    SalonsUserCubit.user.email ?? '',
                    style: TextStyle(color: Colors.white.withOpacity(0.7)),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(Icons.add_box, 'My Products', () {
              GoRouter.of(context).push(AppRouter.kMyProductsView);
            }),
            _buildDrawerItem(Icons.shopping_bag, 'Shop', () {
              GoRouter.of(context).push(AppRouter.kShopView);
            }),
            _buildDrawerItem(Icons.assessment, 'Reports', () {
              GoRouter.of(context).push(AppRouter.kReportsView);
            }),
            _buildDrawerItem(Icons.card_membership, 'Subscription', () {}),
            _buildDrawerItem(Icons.help, 'Help & Support', () {}),
            Divider(),
            _buildDrawerItem(Icons.logout, 'Sign Out', () {
              showCustomConfirmationDialog(
                context: context,
                title: "Sign Out",
                message:
                    "Are you sure you want to sign out of your account?\nYou will need to log in again to access your account.",
                confirmButtonText: "Sign Out",
                onConfirm: () {
                  Navigator.pop(context); // Close dialog
                  context
                      .read<LogOutCubit>()
                      .logOut(); // Use context.read instead of BlocProvider.of
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, void Function()? onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }
}
