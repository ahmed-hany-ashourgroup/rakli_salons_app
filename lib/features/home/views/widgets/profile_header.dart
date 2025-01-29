import 'package:flutter/material.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';
import 'package:rakli_salons_app/core/utils/assets.dart';

// ------------------------------
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

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
                    image: DecorationImage(
                      image: AssetImage(Assets.assetsImagesCover),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).padding.top,
                right: 16,
                child: IconButton(
                  icon: const Icon(Icons.edit_rounded, color: Colors.white),
                  onPressed: () {},
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).padding.top + 8,
                left: 16,
                child: Text(
                  'Mall Beauty Salon',
                  style: AppStyles.bold24.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 16,
          top: 100,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 4),
            ),
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(Assets.assetsImagesProfilephoto),
            ),
          ),
        ),
      ],
    );
  }
}
