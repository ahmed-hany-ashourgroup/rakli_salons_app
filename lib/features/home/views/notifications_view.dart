import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rakli_salons_app/core/customs/custom_app_bar.dart';
import 'package:rakli_salons_app/core/theme/theme_constants.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';
import 'package:rakli_salons_app/features/home/manager/get_notifications_cubit/get_notifications_cubit.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  @override
  void initState() {
    super.initState();
    context.read<GetNotificationsCubit>().getNotifications();
  }

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
              child: BlocBuilder<GetNotificationsCubit, GetNotificationsState>(
                builder: (context, state) {
                  if (state is GetNotificationsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: kPrimaryColor,
                      ),
                    );
                  }

                  if (state is GetNotificationsFailed) {
                    return Center(
                      child: Text(
                        state.errMessage,
                        style: AppStyles.regular13.copyWith(color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  if (state is GetNotificationsSuccess) {
                    final notifications = state.notifications;
                    print('Notifications length: ${notifications.length}');
                    print('Notifications data: $notifications');

                    if (notifications.isEmpty) {
                      return Center(
                        child: Text(
                          'No notifications yet',
                          style:
                              AppStyles.regular13.copyWith(color: Colors.grey),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        final notification = notifications[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: kPrimaryColor.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Icon(
                                          _getNotificationIcon(notification),
                                          color: kPrimaryColor,
                                          size: 24,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _getNotificationTitle(
                                                  notification),
                                              style: AppStyles.bold16.copyWith(
                                                color: Colors.black87,
                                                height: 1.2,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              _getNotificationMessage(
                                                  notification),
                                              style:
                                                  AppStyles.regular13.copyWith(
                                                color: Colors.grey[600],
                                                height: 1.4,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.access_time,
                                                  size: 14,
                                                  color: Colors.grey[400],
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  _formatDate(
                                                      notification.createdAt ??
                                                          ''),
                                                  style: AppStyles.regular14
                                                      .copyWith(
                                                    color: Colors.grey[400],
                                                  ),
                                                ),
                                                if (_getNotificationStatus(
                                                        notification) !=
                                                    null) ...[
                                                  const Spacer(),
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 8,
                                                      vertical: 4,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: _getStatusColor(
                                                              notification)
                                                          .withOpacity(0.1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: Text(
                                                      _getNotificationStatus(
                                                              notification) ??
                                                          '',
                                                      style: AppStyles.medium12
                                                          .copyWith(
                                                        color: _getStatusColor(
                                                            notification),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (notification.isExpanded &&
                                    _getNotificationDetails(notification)
                                        .isNotEmpty)
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[50],
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(12),
                                        bottomRight: Radius.circular(12),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children:
                                          _getNotificationDetails(notification)
                                              .map((detail) => Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 8),
                                                    child: Text(
                                                      detail,
                                                      style: AppStyles.regular13
                                                          .copyWith(
                                                        color: Colors.grey[600],
                                                        height: 1.4,
                                                      ),
                                                    ),
                                                  ))
                                              .toList(),
                                    ),
                                  ),
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        notification.isExpanded =
                                            !notification.isExpanded;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            notification.isExpanded
                                                ? 'Show less'
                                                : 'Show more',
                                            style: AppStyles.regular14.copyWith(
                                              color: kPrimaryColor,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Icon(
                                            notification.isExpanded
                                                ? Icons.keyboard_arrow_up
                                                : Icons.keyboard_arrow_down,
                                            size: 16,
                                            color: kPrimaryColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getNotificationIcon(dynamic notification) {
    final type = notification.type?.toLowerCase() ?? '';
    if (type.contains('booking')) {
      return Icons.calendar_today_outlined;
    } else if (type.contains('business')) {
      return Icons.store_outlined;
    }
    return Icons.notifications_outlined;
  }

  String _getNotificationTitle(dynamic notification) {
    final type = notification.type?.toLowerCase() ?? '';
    if (type.contains('booking')) {
      return 'New Booking Request';
    } else if (type.contains('business')) {
      return 'Business Status Update';
    }
    return 'Notification';
  }

  String _getNotificationMessage(dynamic notification) {
    return notification.data?.message ?? 'No message available';
  }

  List<String> _getNotificationDetails(dynamic notification) {
    final details = <String>[];
    final data = notification.data;

    if (data != null) {
      if (data.bookingId != null) {
        details.add('Booking ID: #${data.bookingId}');
      }
      if (data.startTime != null) {
        final startTime = DateTime.parse(data.startTime);
        final formattedDate = DateFormat('MMM dd, yyyy').format(startTime);
        final formattedTime = DateFormat('hh:mm a').format(startTime);
        details.add('Appointment Date: $formattedDate');
        details.add('Appointment Time: $formattedTime');
      }
      if (data.businessName != null) {
        details.add('Business Name: ${data.businessName}');
      }
    }

    return details;
  }

  String? _getNotificationStatus(dynamic notification) {
    final data = notification.data;
    if (data != null) {
      if (data.requestState != null) {
        return data.requestState.toString().toUpperCase();
      }
      if (data.state != null) {
        return data.state.toString().toUpperCase();
      }
    }
    return null;
  }

  Color _getStatusColor(dynamic notification) {
    final status = _getNotificationStatus(notification)?.toLowerCase();
    switch (status) {
      case 'accepted':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inMinutes < 60) {
        return '${difference.inMinutes} min ago';
      } else if (difference.inHours < 24) {
        return '${difference.inHours} hour ago';
      } else if (difference.inDays < 7) {
        return '${difference.inDays} days ago';
      } else {
        return DateFormat('MMM dd, yyyy').format(date);
      }
    } catch (e) {
      return dateStr;
    }
  }
}
