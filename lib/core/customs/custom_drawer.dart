import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rakli_salons_app/core/customs/custom_confirmation_dialog.dart';
import 'package:rakli_salons_app/core/utils/app_router.dart';
import 'package:rakli_salons_app/features/auth/manager/log_out_cubit/log_out_cubit.dart';
import 'package:rakli_salons_app/features/auth/manager/user_cubit/user_cubit.dart';
import 'package:rakli_salons_app/generated/l10n.dart';
import 'package:rakli_salons_app/main.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogOutCubit, LogOutState>(
      listener: (context, state) {
        if (state is LogOutSuccess) {
          GoRouter.of(context).go(AppRouter.kAccountSelectionView);
        }
      },
      child: Drawer(
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
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      SalonsUserCubit.user.email ?? '',
                      style: TextStyle(color: Colors.white.withOpacity(0.7)),
                    ),
                  ],
                ),
              ),
              _buildDrawerItem(Icons.add_box, S.of(context).myProducts, () {
                GoRouter.of(context).push(AppRouter.kMyProductsView);
              }),
              _buildDrawerItem(Icons.shopping_bag, S.of(context).shop, () {
                GoRouter.of(context).push(AppRouter.kShopView);
              }),
              _buildDrawerItem(
                  Icons.card_membership, S.of(context).subscription, () {
                GoRouter.of(context).push(AppRouter.kSubscriptionView);
              }),
              _buildDrawerItem(Icons.help, S.of(context).helpSupport, () {}),
              const Divider(color: Colors.white24),
              BlocBuilder<LanguageCubit, Locale>(
                builder: (context, locale) {
                  return _buildDrawerItem(
                    Icons.language,
                    locale.languageCode == 'en' ? 'العربية' : 'English',
                    () {
                      context.read<LanguageCubit>().toggleLanguage();
                    },
                  );
                },
              ),
              const Divider(color: Colors.white24),
              _buildDrawerItem(Icons.logout, S.of(context).signOut, () {
                showCustomConfirmationDialog(
                  context: context,
                  title: S.of(context).signOut,
                  message: S.of(context).signOutConfirmation,
                  confirmButtonText: S.of(context).signOut,
                  onConfirm: () {
                    Navigator.pop(context); // Close dialog
                    context.read<LogOutCubit>().logOut();
                  },
                );
              }),
            ],
          ),
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
