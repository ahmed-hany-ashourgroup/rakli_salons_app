import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rakli_salons_app/core/utils/api_service.dart';
import 'package:rakli_salons_app/core/utils/service_locator.dart';
import 'package:rakli_salons_app/features/home/data/models/models/notifications_model.dart';

part 'get_notifications_state.dart';

class GetNotificationsCubit extends Cubit<GetNotificationsState> {
  GetNotificationsCubit() : super(GetNotificationsInitial());
  final ApiService _apiService = getIt.get<ApiService>();

  Future<void> getNotifications() async {
    emit(GetNotificationsLoading());
    try {
      final response = await _apiService.get('notifications');
      final notificationsData = response['data']['notifications'] as List;
      final unreadNotificationsData =
          response['data']['unread_notifications'] as List;

      // Parse notifications
      final notifications = notificationsData
          .map((notification) => NotificationModel.fromJson(notification))
          .toList();

      // Parse unread notifications
      final unreadNotifications = unreadNotificationsData
          .map((notification) => NotificationModel.fromJson(notification))
          .toList();

      emit(GetNotificationsSuccess(
        notifications: notifications,
        unreadNotifications: unreadNotifications,
      ));
    } catch (e) {
      emit(GetNotificationsFailed(
          errMessage: _apiService.handleDioError(e.toString()).message));
    }
  }
}
