import 'package:flutter/material.dart';
import 'package:rakli_salons_app/core/customs/custom_app_bar.dart';
import 'package:rakli_salons_app/core/theme/theme_constants.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';
import 'package:rakli_salons_app/generated/l10n.dart';

class SubscriptionView extends StatelessWidget {
  const SubscriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 56),
            CustomAppBar(
              backButtonColor: kPrimaryColor,
              title: Text(
                S.of(context).plans,
                style: AppStyles.bold24.copyWith(color: Colors.black),
              ),
              icon: const SizedBox.shrink(),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: [
                  _buildPlanCard(
                    context: context,
                    price: 150,
                    isSelected: true,
                    onTap: () {},
                  ),
                  const SizedBox(height: 16),
                  _buildPlanCard(
                    context: context,
                    price: 120,
                    isSelected: false,
                    onTap: () {},
                  ),
                  const SizedBox(height: 16),
                  _buildPlanCard(
                    context: context,
                    price: 100,
                    isSelected: false,
                    onTap: () {},
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: Colors.grey[300]!),
                        ),
                      ),
                      child: Text(
                        S.of(context).cancel,
                        style: AppStyles.medium14
                            .copyWith(color: Colors.grey[600]),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle subscription confirmation
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        S.of(context).confirm,
                        style: AppStyles.medium14.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard({
    required BuildContext context,
    required double price,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? kPrimaryColor : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? kPrimaryColor : Colors.grey[300]!,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).basicPlan,
                  style: AppStyles.bold16.copyWith(
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  '\$$price/Monthly',
                  style: AppStyles.bold16.copyWith(
                    color: isSelected ? Colors.white : kPrimaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              S.of(context).basicPlanDescription,
              style: AppStyles.regular14.copyWith(
                color: isSelected ? Colors.white70 : Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            _buildFeatureItem(
              context,
              S.of(context).manageAppointments,
              isSelected: isSelected,
            ),
            _buildFeatureItem(
              context,
              S.of(context).manageServices,
              isSelected: isSelected,
            ),
            _buildFeatureItem(
              context,
              S.of(context).basicAnalytics,
              isSelected: isSelected,
            ),
            _buildFeatureItem(
              context,
              S.of(context).emailSupport,
              isSelected: isSelected,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(BuildContext context, String text,
      {required bool isSelected}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            Icons.check,
            size: 16,
            color: isSelected ? Colors.white : kPrimaryColor,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: AppStyles.regular14.copyWith(
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
