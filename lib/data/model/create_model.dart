class CreateModel {
  String id;
  String meetingName;
  int countPeople;
  List<DateTime> possibleDates;
  List<int> possibleTimes;

  CreateModel({
    required this.id,
    required this.meetingName,
    required this.countPeople,
    required this.possibleDates,
    required this.possibleTimes,
  });

  factory CreateModel.fromJson(Map<String, dynamic> json) {
    return CreateModel(
      id: json['id'],
      meetingName: json["meeting_name"],
      countPeople: json["count_people"],
      possibleDates: List<String>.from(json["possible_dates"]).map((date) => DateTime.utc(int.parse(date.split('-')[0]), int.parse(date.split('-')[1]), int.parse(date.split('-')[2]))).toList(),
      possibleTimes: List<int>.from(json["possible_times"]),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "meeting_name": meetingName,
        "count_people": countPeople,
        "possible_dates": possibleDates.map((date) => date.toString().split(' ').first).toList(),
        "possible_times": possibleTimes,
      };
}