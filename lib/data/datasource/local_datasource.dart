

import '../model/date_range_model.dart';
import '../model/time_range_model.dart';

List<DateRangeModel> DATE_SHORTCUT_LIST = [
  DateRangeModel(
      rangeName: "이번주",
      start: DateTime.now(),
      days: 8 - DateTime.now().weekday
  ),
  DateRangeModel(
      rangeName: "다음주",
      start: DateTime.now().add(Duration(days: 8-DateTime.now().weekday)),
      days: 7
  ),
  DateRangeModel(
      rangeName: "다다음주",
      start: DateTime.now().add(Duration(days: 15-DateTime.now().weekday)),
      days: 7
  ),
  DateRangeModel(
      rangeName: "이번주말",
      start: DateTime.now().add(Duration(days: DateTime.now().weekday == 7 ? 0 : 6-DateTime.now().weekday)),
      days: DateTime.now().weekday == 7 ? 1 : 2
  ),
  DateRangeModel(
    rangeName: "이번달",
    start: DateTime.now(),
    days: (DateTime.now().month == 12 ? DateTime(DateTime.now().year + 1, 1, 0).day : DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day) - DateTime.now().day + 1,
  ),
];

List<TimeRangeModel> TIME_SHORTCUT_LIST = [
  TimeRangeModel(
    rangeName: '전체',
    start: 0,
    duration: 24,
  ),
  TimeRangeModel(
    rangeName: '오전',
    start: 9,
    duration: 2,
  ),
  TimeRangeModel(
    rangeName: '점심',
    start: 11,
    duration: 3,
  ),
  TimeRangeModel(
    rangeName: '오후',
    start: 14,
    duration: 3,
  ),
  TimeRangeModel(
    rangeName: '저녁',
    start: 17,
    duration: 3,
  ),
  TimeRangeModel(
    rangeName: '밤',
    start: 20,
    duration: 4,
  ),
];

List<DateTime> EVENT_LIST = [
  DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day)
];