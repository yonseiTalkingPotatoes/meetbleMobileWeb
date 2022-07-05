class CreateModel {
  String? meetingName;
  int? numberPeople;
  List<DateTime>? possibleDates;
  List<int>? timeRange;

  CreateModel({
    this.meetingName,
    this.numberPeople,
    this.possibleDates,
    this.timeRange,
  });

  factory CreateModel.fromJson(Map<String, dynamic> json) => CreateModel(
    meetingName: json["meetingName"],
    numberPeople: json["numberPeople"],
    possibleDates: List<DateTime>.from(json["possibleDates"]),
    timeRange: List<int>.from(json["timeRange"]),
  );
}