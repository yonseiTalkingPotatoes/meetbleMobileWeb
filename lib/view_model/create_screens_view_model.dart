import 'package:flutter/cupertino.dart';
import 'package:meetble/data/model/create_model.dart';
import 'package:meetble/data/model/date_range_model.dart';
import 'package:meetble/data/model/time_range_model.dart';

class CreateScreensViewModel extends ChangeNotifier {
  final int _MAX_PEOPLE = 20;
  final int _MIN_PEOPLE = 2;
  CreateModel _createModel = CreateModel(
    meetingName: "",
    numberPeople: 2,
    possibleDates: [],
    timeRange: [],
  );
  List<DateRangeModel> _dateRanges = [
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

  List<TimeRangeModel> _timeRange = [
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

  List<DateTime> _events = [
    DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day)
  ];

  String? _resultMessage;
  String? _inputErrorMessage;
  String? _resultState;
  bool _resultSuccess = false;
  bool _inputOk = false;


  DateTime _selectedDate = DateTime.now();
  int _selectedTime = 0;

  CreateModel get createInfo => _createModel;
  bool get resultSuccess => _resultSuccess;
  String? get resultMessage => _resultMessage;
  String? get resultState => _resultState;
  String? get inputErrorMessage => _inputErrorMessage;
  bool get inputOk => _inputOk;
  DateTime get selectedDate => _selectedDate;
  int get selectedTime => _selectedTime;
  List<DateTime> get events => _events;
  List<DateRangeModel> get dateRanges => _dateRanges;
  List<TimeRangeModel> get timeRange => _timeRange;

  Future<void> checkFirstScreenInputOk() async {
    await checkMeetingName(_createModel.meetingName);
    inputOk ? checkNumberPeople(_createModel.numberPeople.toString()) : null;
    notifyListeners();
  }

  Future<void> checkSecondScreenInputOk() async {
    if(_createModel.possibleDates.isEmpty){
      _inputErrorMessage = '날짜 구간을 설정해주세요';
      _inputOk = false;
    }
    else {
      _inputErrorMessage = null;
      _inputOk = true;
    }
    notifyListeners();
  }

  Future<void> checkThirdScreenInputOk() async {
    if(_createModel.timeRange.isEmpty){
      _inputErrorMessage = '시간대를 설정해주세요';
      _inputOk = false;
    }
    else {
      _inputErrorMessage = null;
      _inputOk = true;
    }
    notifyListeners();
  }

  DateTime normalizeDate(DateTime date) {
    return DateTime.utc(date.year, date.month, date.day);
  }

  cancelInput() {
    _inputErrorMessage = null;
  }

  Future<void> checkMeetingName(String meetingName) async {
    if(meetingName.isEmpty) {
      _createModel.meetingName = meetingName;
      _inputErrorMessage = '모임 제목을 입력해주세요';
      _inputOk = false;
    }
    else{
      _createModel.meetingName = meetingName;
      _inputErrorMessage = null;
      _inputOk = true;
    }
    notifyListeners();
  }

  checkNumberPeople(String numberPeople){
    if(numberPeople.isEmpty) {
      _inputErrorMessage = '입력이 올바르지 않습니다';
      _inputOk = false;
    }
    else if(!RegExp(r'^([0-9]{1,})$').hasMatch(numberPeople)) {
      _inputErrorMessage = '숫자로만 입력해주세요';
      _inputOk = false;
    }
    else if(int.parse(numberPeople) < _MIN_PEOPLE) {
      _createModel.numberPeople = _MIN_PEOPLE;
      _inputErrorMessage = '최소 인원은 ${_MIN_PEOPLE}명입니다';
      _inputOk = false;
    }
    else if(int.parse(numberPeople) > _MAX_PEOPLE) {
      _createModel.numberPeople = _MAX_PEOPLE;
      _inputErrorMessage = '최대 인원은 ${_MAX_PEOPLE}명입니다';
      _inputOk = false;
    }
    else{
      _createModel.numberPeople = int.parse(numberPeople);
      _inputErrorMessage = null;
      _inputOk = true;
    }
    notifyListeners();
  }

  increaseNum(){
    if(_createModel.numberPeople < _MAX_PEOPLE){
      _createModel.numberPeople = _createModel.numberPeople + 1;
      notifyListeners();
    }
  }

  decreaseNum() {
    if(_createModel.numberPeople > _MIN_PEOPLE) {
      _createModel.numberPeople = _createModel.numberPeople - 1;
      notifyListeners();
    }
  }

  isSelectedDate(DateTime dateTime) {
    return _createModel.possibleDates.contains(dateTime);
  }

  toggleDateState(DateTime dateTime) {
    _selectedDate = dateTime;
    if(!_createModel.possibleDates.contains(_selectedDate)){
      _createModel.possibleDates.add(_selectedDate);
      print("add ${_selectedDate}");
    }
    else {
      _createModel.possibleDates.removeAt(_createModel.possibleDates.indexOf(_selectedDate));
      print("remove ${_selectedDate}");
    }
    notifyListeners();
  }

  resetPossibleDates(){
    _createModel.possibleDates = [];
    notifyListeners();
  }

  toggleTimeState(int time) {
    _selectedTime = time;
    if(!_createModel.timeRange.contains(_selectedTime)){
      _createModel.timeRange.add(_selectedTime);
      print("add ${_selectedTime}시");
    }
    else {
      print("엥");
      _createModel.timeRange.removeAt(_createModel.timeRange.indexOf(_selectedTime));
      print("remove ${_selectedTime}시");
    }
    notifyListeners();
  }

  resetPossibleTimes(){
    _createModel.timeRange = [];
    notifyListeners();
  }
}