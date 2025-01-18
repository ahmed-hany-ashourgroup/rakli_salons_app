import 'package:flutter/material.dart';
import 'package:rakli_salons_app/core/customs/custom_app_bar.dart';
import 'package:rakli_salons_app/core/theme/theme_constants.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  final List<Map<String, dynamic>> notifications = [
    {
      'title': "Salons",
      'subtitle': "Hair cutting and styling is the art...",
      'expandedText':
          "Hair cutting and styling is the art of manipulating hair to achieve a desired look.",
      'icon': Icons.content_cut_outlined,
      'time': "30 min ago",
      'isExpanded': false,
    },
    {
      'title': "Product",
      'subtitle': "Your order still in process",
      'expandedText':
          "Your order is being processed and will be delivered soon.",
      'icon': Icons.shopping_cart_outlined,
      'time': "2 hour ago",
      'isExpanded': false,
    },
    {
      'title': "Product",
      'subtitle': "Your order is not approved by picices...",
      'expandedText': "Please contact support for further details.",
      'icon': Icons.shopping_cart_outlined,
      'time': "2 hour ago",
      'isExpanded': false,
    },
    {
      'title': "Offer",
      'subtitle': "Get additional discount when you be...",
      'expandedText':
          "Get additional discount when you become a premium member.",
      'icon': Icons.settings_outlined,
      'time': "2 hour ago",
      'isExpanded': false,
    },
  ];

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
                "Notification",
                style: AppStyles.bold24.copyWith(color: Colors.black),
              ),
              icon: const SizedBox.shrink(),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                notification['icon'],
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    notification['title'],
                                    style: AppStyles.bold16
                                        .copyWith(color: Colors.black),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    notification['subtitle'],
                                    style: AppStyles.regular13
                                        .copyWith(color: Colors.grey),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    notification['time'],
                                    style: AppStyles.light14
                                        .copyWith(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  notifications[index]['isExpanded'] =
                                      !notifications[index]['isExpanded'];
                                });
                              },
                              icon: Icon(
                                notification['isExpanded']
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                color: kPrimaryColor,
                              ),
                            ),
                          ],
                        ),
                        if (notification['isExpanded'])
                          Padding(
                            padding: const EdgeInsets.only(left: 64, top: 8),
                            child: Text(
                              notification['expandedText'],
                              style: AppStyles.regular13
                                  .copyWith(color: Colors.grey),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
