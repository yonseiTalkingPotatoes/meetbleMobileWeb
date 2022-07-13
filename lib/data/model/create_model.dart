class CreateModel {
  String meetingName;
  int numberPeople;
  List<DateTime> possibleDates;
  List<int> timeRange;

  CreateModel({
    required this.meetingName,
    required this.numberPeople,
    required this.possibleDates,
    required this.timeRange,
  });

  factory CreateModel.fromJson(Map<String, dynamic> json) => CreateModel(
    meetingName: json["meetingName"],
    numberPeople: json["numberPeople"],
    possibleDates: List<DateTime>.from(json["possibleDates"]),
    timeRange: List<int>.from(json["timeRange"]),
  );
}