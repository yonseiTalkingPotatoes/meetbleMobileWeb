import 'package:flutter/cupertino.dart';
import 'package:meetble/data/datasource/remote_datasource.dart';
import 'package:meetble/data/model/create_model.dart';

import '../data/repository/create_repository.dart';

class CreateScreensViewModel extends ChangeNotifier {
  final CreateRepository _createRepository = CreateRepository();
  final int maxPeople = 20;
  final int minPeople = 2;
  CreateModel _createModel = CreateModel(
    id: "",
    meetingName: "",
    countPeople: 2,
    possibleDates: [],
    possibleTimes: [],
  );

  String? _resultMessage;
  String? _inputErrorMessage;
  String? _resultState;
  bool _resultSuccess = true;
  bool _inputOk = true;

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

  Future<void> checkFirstScreenInputOk() async {
    await checkMeetingName(_createModel.meetingName);
    inputOk ? checkNumberPeople(_createModel.countPeople.toString()) : null;
    notifyListeners();
  }

  Future<void> checkSecondScreenInputOk() async {
    if (_createModel.possibleDates.isEmpty) {
      _inputErrorMessage = '날짜 구간을 설정해주세요';
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

  Future<void> checkMeetingName(String meetingName) async {
    if (meetingName.isEmpty) {
      _createModel.meetingName = meetingName;
      _inputErrorMessage = '모임 제목을 입력해주세요';
      _inputOk = false;
    } else {
      _createModel.meetingName = meetingName;
      _inputErrorMessage = null;
      _inputOk = true;
    }
    notifyListeners();
  }

  checkNumberPeople(String numberPeople) {
    if (numberPeople.isEmpty) {
      _inputErrorMessage = '입력이 올바르지 않습니다';
      _inputOk = false;
    } else if (!RegExp(r'^([0-9]{1,})$').hasMatch(numberPeople)) {
      _inputErrorMessage = '숫자로만 입력해주세요';
      _inputOk = false;
    } else if (int.parse(numberPeople) < minPeople) {
      _createModel.countPeople = minPeople;
      _inputErrorMessage = '최소 인원은 $minPeople명입니다';
      _inputOk = false;
    } else if (int.parse(numberPeople) > maxPeople) {
      _createModel.countPeople = maxPeople;
      _inputErrorMessage = '최대 인원은 $maxPeople명입니다';
      _inputOk = false;
    } else {
      _createModel.countPeople = int.parse(numberPeople);
      _inputErrorMessage = null;
      _inputOk = true;
    }
    notifyListeners();
  }

  increaseNum() {
    if (_createModel.countPeople < maxPeople) {
      _createModel.countPeople = _createModel.countPeople + 1;
      notifyListeners();
    }
  }

  decreaseNum() {
    if (_createModel.countPeople > minPeople) {
      _createModel.countPeople = _createModel.countPeople - 1;
      notifyListeners();
    }
  }

  togglePossibleDates(DateTime dateTime) {
    _selectedDate = dateTime;
    if (!_createModel.possibleDates.contains(_selectedDate)) {
      _createModel.possibleDates.add(_selectedDate);
    } else {
      _createModel.possibleDates
          .removeAt(_createModel.possibleDates.indexOf(_selectedDate));
    }
    notifyListeners();
  }

  resetPossibleDates() {
    _createModel.possibleDates = [];
    notifyListeners();
  }

  togglePossibleTimes(int time) {
    _selectedTime = time;
    if (!_createModel.possibleTimes.contains(_selectedTime)) {
      _createModel.possibleTimes.add(_selectedTime);
    } else {
      _createModel.possibleTimes
          .removeAt(_createModel.possibleTimes.indexOf(_selectedTime));
    }
    notifyListeners();
  }

  resetPossibleTimes() {
    _createModel.possibleTimes = [];
    notifyListeners();
  }

  Future<void> getMeetingId() async {
    if (_createModel.id.isEmpty) {
      var result =
          await _createRepository.getNewMeetingId(_createModel.meetingName);
      if (result is Success) {
        _createModel.id = result.response["id"];
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

  Future<void> registerMeeting() async {
    var result = await _createRepository.saveMeetingInfo(_createModel);
    if (result is Success) {
      _resultSuccess = true;
      _resultMessage = null;
    } else if (result is Failure) {
      _resultSuccess = false;
      _resultMessage = result.errorResponse;
    }
  }

  clearMeetingInfo() {
    _createModel = CreateModel(
      id: "",
      meetingName: "",
      countPeople: 2,
      possibleDates: [],
      possibleTimes: [],
    );
  }
}
