class UserScheduleModel {
  String id;
  String userName;
  List<DateStatusModel> selectedDates;

  UserScheduleModel({
    required this.id,
    required this.userName,
    required this.selectedDates,
  });

  factory UserScheduleModel.fromJson(Map<String, dynamic> json) => UserScheduleModel(
    id: json['id'],
    userName: json['user_name'],
    selectedDates: (json["selected_dates"] as List).map((i) => DateStatusModel.fromJson(i)).toList(),
  );

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'user_name': userName,
        'selected_dates': selectedDates.map((selectedDate) => selectedDate.toJson()).toList(),
      };
}

class DateStatusModel {
  DateTime date;
  String memo;
  List<TimeStatusModel> timeBlock;


  DateStatusModel({
    required this.date,
    required this.memo,
    required this.timeBlock,
  });

  factory DateStatusModel.fromJson(Map<String, dynamic> json) => DateStatusModel(
    date: DateTime.utc(int.parse(json['date'].split('-')[0]), int.parse(json['date'].split('-')[1]), int.parse(json['date'].split('-')[2])),
    memo: json["memo"],
    timeBlock: (json["time_block"] as List).map((i) => TimeStatusModel.fromJson(i)).toList(),
  );

  Map<String, dynamic> toJson() =>
      {
        'date': date.toString().split(' ').first,
        'memo': memo,
        'time_block': timeBlock.map((time) => time.toJson()).toList(),
      };
}

class TimeStatusModel {
  int time;
  int statusCode;

  TimeStatusModel({
    required this.time,
    required this.statusCode,
  });

  factory TimeStatusModel.fromJson(Map<String, dynamic> json) => TimeStatusModel(
    time: json['time'],
    statusCode: json["status_code"],
  );

  Map<String, dynamic> toJson() =>
      {
        'time': time,
        'status_code': statusCode,
      };
}