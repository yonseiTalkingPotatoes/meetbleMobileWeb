import 'package:flutter/cupertino.dart';
import 'package:meetble/data/model/create_model.dart';

class CreateScreensViewModel extends ChangeNotifier {
  final int _MAX_PEOPLE = 20;
  final int _MIN_PEOPLE = 2;
  CreateModel _createModel = CreateModel(numberPeople: 2);
  String? _resultMessage;
  String? _inputErrorMessage;
  String? _resultState;
  bool _resultSuccess = false;
  bool _inputOk = false;

  CreateModel get createInfo => _createModel;
  bool get resultSuccess => _resultSuccess;
  String? get resultMessage => _resultMessage;
  String? get resultState => _resultState;
  String? get inputErrorMessage => _inputErrorMessage;
  bool get inputOk => _inputOk;

  Future<void> checkFirstScreenInputOk() async {
    await checkMeetingName(_createModel.meetingName??"");
    inputOk ? checkNumberPeople(_createModel.numberPeople.toString()) : null;
    notifyListeners();
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
    if(_createModel.numberPeople! < _MAX_PEOPLE){
      _createModel.numberPeople = _createModel.numberPeople! + 1;
      notifyListeners();
    }
  }

  decreaseNum() {
    if(_createModel.numberPeople! > _MIN_PEOPLE) {
      _createModel.numberPeople = _createModel.numberPeople! - 1;
      notifyListeners();
    }
  }
}