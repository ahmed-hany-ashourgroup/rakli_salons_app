import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rakli_salons_app/core/theme/theme_constants.dart';
import 'package:rakli_salons_app/core/utils/app_router.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';
import 'package:rakli_salons_app/core/utils/assets.dart';
import 'package:rakli_salons_app/features/home/views/prfofile_view.dart';

class ProfileTabBar extends StatelessWidget {
  const ProfileTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: const [
        Tab(text: 'Profile'),
        Tab(text: 'Account'),
      ],
      labelColor: kPrimaryColor,
      labelStyle: AppStyles.bold14,
      unselectedLabelColor: Colors.black,
      indicatorColor: kPrimaryColor,
    );
  }
}

// ------------------------------
// Profile Tab
// ------------------------------
class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VideoSection(),
          const SizedBox(height: 16),
          const SalonInformation(),
          const SizedBox(height: 150),
        ],
      ),
    );
  }
}

class SalonInformation extends StatelessWidget {
  const SalonInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Mall Beauty Salon', style: AppStyles.bold24),
            const SizedBox(width: 8),
            const Icon(Icons.verified, color: kPrimaryColor),
          ],
        ),
        const SizedBox(height: 16),
        Text('Description', style: AppStyles.medium20),
        const SizedBox(height: 8),
        Text(
          'Hair cutting and styling is the art of manipulating hair to achieve a desired look...',
          style: AppStyles.regular16,
        ),
        const SizedBox(height: 16),
        const LocationInfo(),
      ],
    );
  }
}

class LocationInfo extends StatelessWidget {
  const LocationInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(Icons.location_on, color: kPrimaryColor),
            const SizedBox(width: 8),
            Text('13 km', style: AppStyles.regular16),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Icon(Icons.phone, color: kPrimaryColor),
            const SizedBox(width: 8),
            Text('+20 11 5757 4822', style: AppStyles.regular16),
          ],
        ),
      ],
    );
  }
}

// ------------------------------
// Account Tab
// ------------------------------
class AccountTab extends StatelessWidget {
  const AccountTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          CustomProfileTile(
            iconPath: Assets.assetsImagesHeart,
            title: 'Favorite',
            onTap: () => GoRouter.of(context).push(AppRouter.kFavoritesView),
          ),
          CustomProfileTile(
            iconPath: Assets.assetsImagesLock,
            title: 'Change Password',
            onTap: () {},
          ),
          CustomProfileTile(
            iconPath: Assets.assetsImagesOrder,
            title: 'Order',
            onTap: () => GoRouter.of(context).push(AppRouter.kOrdersView),
          ),
          const SizedBox(height: 20),
          const PaymentCards(),
        ],
      ),
    );
  }
}

class PaymentCards extends StatelessWidget {
  const PaymentCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Payment Cards', style: AppStyles.medium20),
        const SizedBox(height: 16),
        const PaymentCard(
            title: 'Main Card', number: 'Visa **** **** **** 4587'),
        const PaymentCard(
            title: 'Oscars Card', number: 'Visa **** **** **** 1234'),
        const SizedBox(height: 16),
        AddNewCardButton(),
      ],
    );
  }
}

class PaymentCard extends StatelessWidget {
  final String title;
  final String number;

  const PaymentCard({super.key, required this.title, required this.number});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.credit_card, color: kPrimaryColor),
        title: Text(title),
        subtitle: Text(number),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}

class AddNewCardButton extends StatelessWidget {
  const AddNewCardButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.add),
      label: const Text('Add New Card'),
    );
  }
}
