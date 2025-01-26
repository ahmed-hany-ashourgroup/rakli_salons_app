part of 'get_notifications_cubit.dart';

@immutable
abstract class GetNotificationsState {}

class GetNotificationsInitial extends GetNotificationsState {}

class GetNotificationsLoading extends GetNotificationsState {}

class GetNotificationsSuccess extends GetNotificationsState {
  final List<NotificationModel> notifications;
  final List<NotificationModel> unreadNotifications;

  GetNotificationsSuccess({
    required this.notifications,
    required this.unreadNotifications,
  });
}

class GetNotificationsFailed extends GetNotificationsState {
  final String errMessage;
  GetNotificationsFailed({required this.errMessage});
}
