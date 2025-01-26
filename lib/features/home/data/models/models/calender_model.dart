class CalendarModel {
  final int? id;
  final int? businessId;
  final List<String>? fixedHolidays;
  final List<String>? variableHolidays;
  final bool? allDay;
  final String? startAt;
  final String? endAt;
  final String? createdAt;
  final String? updatedAt;

  CalendarModel({
    this.id,
    this.businessId,
    this.fixedHolidays,
    this.variableHolidays,
    this.allDay,
    this.startAt,
    this.endAt,
    this.createdAt,
    this.updatedAt,
  });

  factory CalendarModel.fromJson(Map<String, dynamic> json) {
    return CalendarModel(
      id: json['id'] as int?,
      businessId: json['business_id'] as int?,
      fixedHolidays: json['fixed_holidays'] != null
          ? List<String>.from(json['fixed_holidays'])
          : null,
      variableHolidays: json['variable_holidays'] != null
          ? List<String>.from(json['variable_holidays'])
          : null,
      allDay: json['all_day'] as bool?,
      startAt: json['start_at'] as String?,
      endAt: json['end_at'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'business_id': businessId,
      'fixed_holidays': fixedHolidays,
      'variable_holidays': variableHolidays,
      'all_day': allDay,
      'start_at': startAt,
      'end_at': endAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
