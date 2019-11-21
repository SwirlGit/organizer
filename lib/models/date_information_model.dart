class DateInformation {
  DateTime _createdAt;
  DateTime targetDate;

  DateTime get createdAt => _createdAt;

  DateInformation({this.targetDate}) {
    _createdAt = DateTime.now().toUtc();
  }

  DateInformation.fromJson(Map<String, Object> json)
      : _createdAt = json["createdAt"] as DateTime,
        targetDate = json["targetDate"] as DateTime;

  Map<String, Object> toJson() {
    return {
      "createdAt": createdAt,
      "targetDate": targetDate,
    };
  }

  @override
  int get hashCode => createdAt.hashCode ^ targetDate.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is DateInformation &&
              runtimeType == other.runtimeType &&
              createdAt == other.createdAt &&
              targetDate == other.targetDate;

  @override
  String toString() {
    return 'DateInformation{createdAt: $createdAt, targetDate: $targetDate';
  }

}