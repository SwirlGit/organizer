class DateInformation {
  DateTime _createdAt;
  DateTime targetDate;

  DateTime get createdAt => _createdAt;

  DateInformation({this.targetDate}) {
    _createdAt = DateTime.now().toUtc();
  }

  DateInformation.fromJson(Map<String, Object> json)
      : _createdAt = DateTime.parse(json["createdAt"] as String).toUtc(),
        targetDate = DateTime.parse(json["targetDate"] as String).toUtc();

  Map<String, Object> toJson() {
    return {
      "createdAt": createdAt.toIso8601String(),
      "targetDate": targetDate.toIso8601String(),
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