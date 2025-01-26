import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rakli_salons_app/core/theme/theme_constants.dart';
import 'package:rakli_salons_app/core/utils/app_router.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';
import 'package:rakli_salons_app/core/utils/assets.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              clipBehavior: Clip.none, // Allows profile photo to overflow
              children: [
                // Cover photo with black overlay
                SizedBox(
                  height: 180, // Adjust height as needed
                  width: double.infinity,
                  child: Stack(
                    children: [
                      // Black background
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(32),
                            bottomRight: Radius.circular(32),
                          ),
                          color: Colors.black,
                        ),
                      ),
                      // Cover image with opacity
                      Opacity(
                        opacity: 0.7, // Adjust opacity as needed
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
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
                      // Edit button
                      Positioned(
                        top: MediaQuery.of(context).padding.top,
                        right: 16,
                        child: IconButton(
                          icon: Icon(Icons.edit_rounded, color: Colors.white),
                          onPressed: () {},
                        ),
                      ),
                      // Salon data
                      Positioned(
                        top: MediaQuery.of(context).padding.top + 8,
                        left: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mall Beauty Salon',
                              style: AppStyles.bold24
                                  .copyWith(color: Colors.white),
                            ),
                            SizedBox(height: 4),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Profile photo
                Positioned(
                  right: 16,
                  top: 100, // Adjust this value to position the profile photo
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          AssetImage(Assets.assetsImagesProfilephoto),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            // Tab bar below cover photo
            TabBar(
              tabs: [
                Tab(text: 'Profile'),
                Tab(text: 'Account'),
              ],
              labelColor: kPrimaryColor,
              labelStyle: AppStyles.bold14,
              unselectedLabelColor: Colors.black,
              indicatorColor: kPrimaryColor,
            ),
            // Tab view content
            Expanded(
              child: TabBarView(
                children: [
                  _buildProfileTab(),
                  _buildAccountTab(context: context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountTab({required BuildContext context}) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Favorite
          CustomProfileTile(
            iconPath: Assets.assetsImagesHeart, // Replace with your icon path
            title: 'Favorite',
            onTap: () {
              GoRouter.of(context).push(AppRouter.kFavoritesView);
            },
            iconColor: Colors.white,
          ),
          // Change Password
          CustomProfileTile(
            iconPath: Assets.assetsImagesLock, // Replace with your icon path
            title: 'Change Password',
            onTap: () {},
            iconColor: Colors.white,
          ),
          // Order
          CustomProfileTile(
            iconPath: Assets.assetsImagesOrder, // Replace with your icon path
            title: 'Order',
            onTap: () {
              GoRouter.of(context).push(AppRouter.kOrdersView);
            },
            iconColor: Colors.white,
          ),
          SizedBox(height: 20),
          Text(
            'Payment Cards',
            style: AppStyles.medium20,
          ),
          SizedBox(height: 16),
          _buildPaymentCard(
            'Main Card',
            'Visa **** **** **** 4587',
          ),
          _buildPaymentCard(
            'Oscars Card',
            'Visa **** **** **** 1234',
          ),
          SizedBox(height: 16),
          _buildAddNewCardButton(),
          SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildProfileTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Video Section with Padding
          Padding(
            padding: EdgeInsets.all(16), // Added padding around the video
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                children: [
                  Image.asset(
                    Assets.assetsImagesSalon1,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  Center(
                    child: Icon(
                      Icons.play_circle_fill,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Salon Information Section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16), // Horizontal padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Salon Name and Verified Icon
                Row(
                  children: [
                    Text(
                      'Mall Beauty Salon',
                      style: AppStyles.bold24,
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.verified, color: kPrimaryColor),
                  ],
                ),
                SizedBox(height: 16), // Spacing below salon name

                // Description Section
                _buildDescriptionSection(),
                SizedBox(height: 16), // Spacing below description

                // Information Section
                _buildInformationSection(),
                SizedBox(height: 16), // Spacing below information

                // Location Section
                _buildLocationSection(),
                SizedBox(height: 16), // Spacing below location

                // Distance Section
                Row(
                  children: [
                    Icon(Icons.location_on, color: kPrimaryColor),
                    SizedBox(width: 8),
                    Text(
                      '13 km', // Distance
                      style: AppStyles.regular16,
                    ),
                  ],
                ),
                SizedBox(height: 16), // Spacing below distance

                // Phone Number Section
                Row(
                  children: [
                    Icon(Icons.phone, color: kPrimaryColor),
                    SizedBox(width: 8),
                    Text(
                      '+20 11 5757 4822', // Phone number
                      style: AppStyles.regular16,
                    ),
                  ],
                ),
                SizedBox(height: 32), // Spacing below phone number

                // Social Media Section
                _buildSocialMediaSection(),
                SizedBox(height: 150), // Extra spacing at the bottom
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentCard(String title, String number) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.credit_card, color: kPrimaryColor),
        title: Text(title),
        subtitle: Text(number),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }

  Widget _buildAddNewCardButton() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: kPrimaryColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add, color: kPrimaryColor),
          SizedBox(width: 8),
          Text('Add New Card', style: TextStyle(color: kPrimaryColor)),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: AppStyles.medium20,
        ),
        SizedBox(height: 8),
        Text(
          'Hair cutting and styling is the art of manipulating hair to achieve a desired look. It encompasses a wide range of techniques...',
          style: AppStyles.regular16,
        ),
      ],
    );
  }

  Widget _buildInformationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Information',
          style: AppStyles.medium20,
        ),
        SizedBox(height: 8),
        _buildTimeRow('Monday - Thursday', '10:00 AM - 11:00 PM'),
        SizedBox(height: 8),
        _buildTimeRow('Friday - Sunday', '01:00 PM - 11:00 PM'),
      ],
    );
  }

  Widget _buildLocationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Location',
          style: AppStyles.medium20,
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Text(
                'Great Pyramids Road, The Nile River Avenue ST',
                style: AppStyles.regular16,
              ),
            ),
            Icon(Icons.location_on, color: kPrimaryColor),
          ],
        ),
      ],
    );
  }

  Widget _buildTimeRow(String days, String hours) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(days, style: AppStyles.regular16),
        Text(hours, style: AppStyles.regular16),
      ],
    );
  }

  Widget _buildSocialMediaSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SvgPicture.asset(
          Assets.assetsImagesFacebook,
          height: 40,
          colorFilter: ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
        ),
        SvgPicture.asset(
          Assets.assetsImagesInsta,
          height: 40,
          colorFilter: ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
        ),
        SvgPicture.asset(
          Assets.assetsImagesTiktok,
          height: 40,
          colorFilter: ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
        ),
        SvgPicture.asset(
          Assets.assetsImagesYoutube,
          height: 40,
          colorFilter: ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
        ),
      ],
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
