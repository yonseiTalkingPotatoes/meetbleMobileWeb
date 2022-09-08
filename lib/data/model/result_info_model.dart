class ResultInfoModel {
  String meetingName;
  String id;
  int countPeople;
  int countJoiningPeople;
  List<DateResultModel> dateTimes;

ResultInfoModel({
  required this.meetingName,
  required this.id,
  required this.countPeople,
  required this.countJoiningPeople,
  required this.dateTimes,
});

  factory ResultInfoModel.fromJson(Map<String, dynamic> json) => ResultInfoModel(
    meetingName: json['meeting_name'],
    id: json['id'],
    countPeople: json['count_people'],
    countJoiningPeople: json['count_joining_people'],
    dateTimes: (json["datetimes"] as List).map((i) => DateResultModel.fromJson(i)).toList(),
  );
}

class DateResultModel {
  DateTime dateTime;
  int numberPossiblePeople;
  int numberImpossiblePeople;
  int numberUncertainPeople;
  List<String> possiblePeople;
  List<String> impossiblePeople;
  List<String> uncertainPeople;

  DateResultModel({
    required this.dateTime,
    required this.numberPossiblePeople,
    required this.numberImpossiblePeople,
    required this.numberUncertainPeople,
    required this.possiblePeople,
    required this.impossiblePeople,
    required this.uncertainPeople,
  });

  factory DateResultModel.fromJson(Map<String, dynamic> json) => DateResultModel(
    dateTime: DateTime.parse(json['datetime']),
    numberPossiblePeople: json["number_possible_people"],
    numberImpossiblePeople: json["number_impossible_people"],
    numberUncertainPeople: json["number_uncertain_people"],
    possiblePeople: json["possible_people"].toString()=='null' ? [] : List<String>.from(json["possible_people"] as List),
    impossiblePeople: json["impossible_people"].toString()=='null' ? [] : List<String>.from([] + (json["impossible_people"] as List)),
    uncertainPeople: json["uncertain_people"].toString()=='null' ? [] : List<String>.from([] + (json["uncertain_people"] as List)),
  );
}