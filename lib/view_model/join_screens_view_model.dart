import 'package:flutter/cupertino.dart';
import 'package:meetble/data/datasource/remote_datasource.dart';
import 'package:meetble/data/model/create_model.dart';
import 'package:meetble/data/model/user_schedule_model.dart';
import 'package:meetble/data/repository/join_repository.dart';

class JoinScreensViewModel extends ChangeNotifier {
  final JoinRepository _joinRepository = JoinRepository();
  CreateModel _createModel = CreateModel(
    id: "",
    meetingName: "",
    countPeople: 2,
    possibleDates: [],
    possibleTimes: [],
  );

  UserScheduleModel _userScheduleModel =
      UserScheduleModel(id: '', userName: "", selectedDates: []);

  String? _resultMessage;
  String? _inputErrorMessage;
  String? _resultState;
  bool _resultSuccess = false;
  bool _inputOk = true;
  final List<DateTime> _impossibleDates = [];
  DateStatusModel? _selectedDateStatus;
  DateTime _firstDate = DateTime.now();
  DateTime _lastDate = DateTime.utc(2030, 12, 31);

  DateTime _selectedDate = DateTime.now();
  int _selectedTime = 0;

  CreateModel get createModel => _createModel;
  UserScheduleModel get userScheduleModel => _userScheduleModel;
  bool get resultSuccess => _resultSuccess;
  String? get resultMessage => _resultMessage;
  String? get resultState => _resultState;
  String? get inputErrorMessage => _inputErrorMessage;
  bool get inputOk => _inputOk;
  DateTime get selectedDate => _selectedDate;
  int get selectedTime => _selectedTime;
  List<DateTime> get impossibleDates => _impossibleDates;
  DateStatusModel get selectedDateStatus => _selectedDateStatus!;
  DateTime get lastDate => _lastDate;
  DateTime get firstDate => _firstDate;

  Future<void> checkFirstScreenInputOk() async {
    await checkUserName(_userScheduleModel.userName);
    notifyListeners();
  }

  Future<void> checkSecondScreenInputOk() async {
    if (_createModel.possibleDates.isEmpty) {
      _inputErrorMessage = '가능한 날짜를 선택해주세요';
      _inputOk = false;
    } else {
      _inputErrorMessage = null;
      _inputOk = true;
    }
    notifyListeners();
  }

  Future<void> checkThirdScreenInputOk() async {
    if (_createModel.possibleTimes.isEmpty) {
      _inputErrorMessage = '시간대를 설정해주세요';
      _inputOk = false;
    } else {
      _inputErrorMessage = null;
      _inputOk = true;
    }
    notifyListeners();
  }

  Future<void> checkUserName(String userName) async {
    if (userName.isEmpty) {
      _userScheduleModel.userName = userName;
      _inputErrorMessage = '닉네임을 입력해주세요';
      _inputOk = false;
    } else {
      _userScheduleModel.userName = userName;
      _inputErrorMessage = null;
      _inputOk = true;
    }
    notifyListeners();
  }

  focusOnFirstDate() {
    focusOnDate(_firstDate);
  }

  focusOnDate(DateTime dateTime) {
    _selectedDate = dateTime;
    _selectedDateStatus = _userScheduleModel.selectedDates
        .firstWhere((dateStatus) => dateStatus.date == _selectedDate);
    notifyListeners();
  }

  toggleDateState(DateTime dateTime) {
    _selectedDate = dateTime;
    if (!_impossibleDates.contains(_selectedDate)) {
      //_userScheduleModel.selectedDates.firstWhere((dateStatusModel) => dateStatusModel.date == dateTime).timeBlock.forEach((timeStatusModel) => timeStatusModel.statusCode = 0);
      _impossibleDates.add(_selectedDate);
    } else {
      //_userScheduleModel.selectedDates.removeAt(_userScheduleModel.selectedDates.indexWhere((dateStatusModel) => dateStatusModel.date == dateTime));
      _impossibleDates.removeAt(_impossibleDates.indexOf(_selectedDate));
    }
    notifyListeners();
  }

  Future updateImpossibleDates() async {
    for (DateTime dateTime in _impossibleDates) {
      _userScheduleModel.selectedDates
          .firstWhere((dateStatusModel) => dateStatusModel.date == dateTime)
          .timeBlock
          .forEach((timeStatusModel) => timeStatusModel.statusCode = 2);
    }
  }

  toggleTimeState(int time) {
    _selectedTime = time;
    int newStatusCode = (_selectedDateStatus!.timeBlock
                .firstWhere(
                    (timeStatusModel) => timeStatusModel.time == _selectedTime)
                .statusCode +
            1) %
        3;
    _selectedDateStatus!.timeBlock
        .firstWhere((timeStatusModel) => timeStatusModel.time == _selectedTime)
        .statusCode = newStatusCode;

    if (_selectedDateStatus!.timeBlock
        .every((timeStatusModel) => timeStatusModel.statusCode == 2)) {
      if (!_impossibleDates.contains(_selectedDate)) {
        _impossibleDates.add(_selectedDate);
      }
    } else {
      if (_impossibleDates.contains(_selectedDate)) {
        _impossibleDates.removeAt(_impossibleDates.indexOf(_selectedDate));
      }
    }
    notifyListeners();
  }

  editMemo(String? memo) {
    if (memo != null) {
      _selectedDateStatus!.memo = memo;
    }
    notifyListeners();
  }

  Future<void> getMeetingInfo(String meetingId) async {
    if (_createModel.id.isEmpty) {
      var result = await _joinRepository.getMeetingInfo(meetingId);
      if (result is Success) {
        _createModel = CreateModel.fromJson(result.response);
        _firstDate = _createModel.possibleDates.first;
        _selectedDate = _firstDate;
        _lastDate = _createModel.possibleDates.last;
        _userScheduleModel.id = _createModel.id;
        for (DateTime date in _createModel.possibleDates) {
          List<TimeStatusModel> _timeStatusList = [];
          for (int time in _createModel.possibleTimes) {
            _timeStatusList.add(TimeStatusModel(time: time, statusCode: 0));
          }
          _userScheduleModel.selectedDates.add(DateStatusModel(
              date: date, timeBlock: _timeStatusList, memo: ''));
        }
        _resultSuccess = true;
        _resultMessage = null;
      } else if (result is Failure) {
        _resultSuccess = false;
        _resultMessage = result.errorResponse;
      }
    } else {
      _resultSuccess = true;
      _resultMessage = null;
    }
  }

  Future registerJoinInfo() async {
    focusOnFirstDate();
    var result = await _joinRepository.saveJoinInfo(_userScheduleModel);
    if (result is Success) {
      _resultSuccess = true;
      _resultMessage = null;
    } else if (result is Failure) {
      _resultSuccess = false;
      _resultMessage = result.errorResponse;
    }
    _resultSuccess = true;
    _resultMessage = null;
  }

  clearJoinInfo() {
    _createModel = CreateModel(
      id: "",
      meetingName: "",
      countPeople: 2,
      possibleDates: [],
      possibleTimes: [],
    );

    _userScheduleModel =
        UserScheduleModel(id: '', userName: '', selectedDates: []);
  }
}
