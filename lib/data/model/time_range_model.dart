class TimeRangeModel {
  String rangeName;
  int start;
  int duration;

  TimeRangeModel({
    required this.rangeName,
    required this.start,
    required this.duration
  });

  factory TimeRangeModel.fromJson(Map<String, dynamic> json) => TimeRangeModel(
    rangeName: json["rangeName"],
    start: json["start"],
    duration: json["duration"],
  );
}