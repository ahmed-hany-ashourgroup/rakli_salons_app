enum AppointmentStatus { pending, confirmed, cancelled, completed }

class Appointment {
  final String? requestUserName;
  AppointmentStatus? status;
  final num? price;
  final DateTime? date;
  final String? comment;

  Appointment({
    this.requestUserName,
    this.status,
    this.price,
    this.date,
    this.comment,
  });
}
