class DateRangeModel {
  String rangeName;
  DateTime start;
  int days;

  DateRangeModel({
    required this.rangeName,
    required this.start,
    required this.days
  });

  factory DateRangeModel.fromJson(Map<String, dynamic> json) => DateRangeModel(
    rangeName: json["rangeName"],
    start: json["start"],
    days: json["days"],
  );
}