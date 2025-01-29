import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rakli_salons_app/core/theme/theme_constants.dart';
import 'package:rakli_salons_app/core/utils/assets.dart';
import 'package:rakli_salons_app/features/auth/manager/user_cubit/user_cubit.dart';
import 'package:rakli_salons_app/features/home/views/widgets/profile_header.dart';
import 'package:rakli_salons_app/features/home/views/widgets/profile_tab_bar.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            ProfileHeader(
              user: SalonsUserCubit.user,
            ),
            const SizedBox(height: 16),
            const ProfileTabBar(),
            const Expanded(
              child: TabBarView(
                children: [
                  ProfileTab(),
                  AccountTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoSection extends StatelessWidget {
  const VideoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: [
          Image.asset(
            Assets.assetsImagesSalon1,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          const Center(
            child: Icon(Icons.play_circle_fill, size: 60, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class CustomProfileTile extends StatelessWidget {
  final String iconPath;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Color iconColor;

  const CustomProfileTile({
    super.key,
    required this.iconPath,
    required this.title,
    this.subtitle,
    this.onTap,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            height: 40,
            width: 40,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: kPrimaryColor, // Use your primary color here
            ),
            child: SvgPicture.asset(
              iconPath,
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
            ),
          ),
          title: Text(title),
          subtitle: subtitle != null ? Text(subtitle!) : null,
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: onTap,
        ),
        const Divider(),
      ],
    );
  }
}
