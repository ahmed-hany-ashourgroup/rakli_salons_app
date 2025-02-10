enum AppointmentStatus { pending, accepted, rejected }

class AppointmentsModel {
  final int id;
  final String? requestUserName;
  AppointmentStatus status;
  final num price;
  final DateTime date;
  final String? comment;

  AppointmentsModel({
    required this.id,
    this.requestUserName,
    required this.status,
    required this.price,
    required this.date,
    this.comment,
  });

  factory AppointmentsModel.fromJson(Map<String, dynamic> json) {
    return AppointmentsModel(
      id: json['id'],
      requestUserName:
          "User #${json['user_id']}", // Placeholder until user name is available
      status: _mapStatus(json['request_state']),
      price: num.parse(json['price_after_promotion']),
      date: DateTime.parse(json['start_time']),
      comment: json['comment'],
    );
  }

  static AppointmentStatus _mapStatus(String status) {
    switch (status) {
      case 'pending':
        return AppointmentStatus.pending;
      case 'accepted':
        return AppointmentStatus.accepted;
      case 'rejected':
        return AppointmentStatus.rejected;
      default:
        return AppointmentStatus.pending;
    }
  }
}
