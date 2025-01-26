import 'package:flutter/material.dart';
import 'package:rakli_salons_app/core/theme/theme_constants.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';

class ReportsView extends StatelessWidget {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildReportItem(
            context,
            title: 'Appointment',
            onTap: () {
              // Navigate to Appointment Reports
            },
          ),
          const SizedBox(height: 16),
          _buildReportItem(
            context,
            title: 'Revenue',
            onTap: () {
              // Navigate to Revenue Reports
            },
          ),
          const SizedBox(height: 16),
          _buildReportItem(
            context,
            title: 'Product Sales',
            onTap: () {
              // Navigate to Product Sales Reports
            },
          ),
          const SizedBox(height: 16),
          _buildReportItem(
            context,
            title: 'Discount and Offer',
            onTap: () {
              // Navigate to Discount and Offer Reports
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReportItem(BuildContext context,
      {required String title, required VoidCallback onTap}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        title: Text(
          title,
          style: AppStyles.bold20.copyWith(color: kPrimaryColor),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: kPrimaryColor),
        onTap: onTap,
      ),
    );
  }
}
