import 'package:flutter/material.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';
import 'package:rakli_salons_app/features/auth/data/models/user_model.dart';

// ------------------------------
class ProfileHeader extends StatelessWidget {
  final BuisnessUserModel user;

  const ProfileHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          height: 180,
          width: double.infinity,
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                  color: Colors.black,
                ),
              ),
              Opacity(
                opacity: 0.7,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                    image: user.cover != null
                        ? DecorationImage(
                            image: NetworkImage(user.cover!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).padding.top + 8,
                left: 16,
                child: Text(
                  user.name ?? 'Unknown',
                  style: AppStyles.bold24.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 16,
          top: 100,
          child: CircleAvatar(
            radius: 50,
            backgroundImage:
                user.photo != null ? NetworkImage(user.photo!) : null,
            backgroundColor: Colors.grey[300],
          ),
        ),
      ],
    );
  }
}
