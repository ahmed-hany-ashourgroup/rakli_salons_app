class NotificationModel {
  final String? id;
  final String? type;
  final String? notifiableType;
  final int? notifiableId;
  final NotificationDataModel? data;
  final String? readAt;
  final String? createdAt;
  final String? updatedAt;
  bool isExpanded; // Add this property

  NotificationModel({
    this.id,
    this.type,
    this.notifiableType,
    this.notifiableId,
    this.data,
    this.readAt,
    this.createdAt,
    this.updatedAt,
    this.isExpanded = false, // Initialize to false
  });

  // Factory method to create a NotificationModel from JSON
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String?,
      type: json['type'] as String?,
      notifiableType: json['notifiable_type'] as String?,
      notifiableId: json['notifiable_id'] as int?,
      data: json['data'] != null
          ? NotificationDataModel.fromJson(json['data'])
          : null,
      readAt: json['read_at'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      isExpanded: false, // Initialize to false when parsing JSON
    );
  }

  // Method to convert a NotificationModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'notifiable_type': notifiableType,
      'notifiable_id': notifiableId,
      'data': data?.toJson(),
      'read_at': readAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'isExpanded': isExpanded, // Include isExpanded in JSON
    };
  }
}

class NotificationDataModel {
  final String? type;
  final int? bookingId;
  final int? userId;
  final int? businessId;
  final String? startTime;
  final String? state;
  final String? requestState;
  final String? message;
  final String? businessName;
  final String? updatedAt;

  NotificationDataModel({
    this.type,
    this.bookingId,
    this.userId,
    this.businessId,
    this.startTime,
    this.state,
    this.requestState,
    this.message,
    this.businessName,
    this.updatedAt,
  });

  factory NotificationDataModel.fromJson(Map<String, dynamic> json) {
    return NotificationDataModel(
      type: json['type'] as String?,
      bookingId: json['booking_id'] as int?,
      userId: json['user_id'] as int?,
      businessId: json['business_id'] as int?,
      startTime: json['start_time'] as String?,
      state: json['state'] as String?,
      requestState: json['request_state'] as String?,
      message: json['message'] as String?,
      businessName: json['business_name'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'booking_id': bookingId,
      'user_id': userId,
      'business_id': businessId,
      'start_time': startTime,
      'state': state,
      'request_state': requestState,
      'message': message,
      'business_name': businessName,
      'updated_at': updatedAt,
    };
  }
}

class NotificationsDataModel {
  final List<NotificationModel>? notifications;
  final List<NotificationModel>? unreadNotifications;

  NotificationsDataModel({
    this.notifications,
    this.unreadNotifications,
  });

  // Factory method to create a NotificationsDataModel from JSON
  factory NotificationsDataModel.fromJson(Map<String, dynamic> json) {
    return NotificationsDataModel(
      notifications: json['notifications'] != null
          ? (json['notifications'] as List)
              .map((item) => NotificationModel.fromJson(item))
              .toList()
          : null,
      unreadNotifications: json['unread_notifications'] != null
          ? (json['unread_notifications'] as List)
              .map((item) => NotificationModel.fromJson(item))
              .toList()
          : null,
    );
  }

  // Method to convert a NotificationsDataModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'notifications': notifications?.map((item) => item.toJson()).toList(),
      'unread_notifications':
          unreadNotifications?.map((item) => item.toJson()).toList(),
    };
  }
}
