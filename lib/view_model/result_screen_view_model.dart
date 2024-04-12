import 'package:flutter/material.dart';
import 'package:meetble/data/repository/result_repository.dart';

import '../data/datasource/remote_datasource.dart';
import '../data/model/result_info_model.dart';

class ResultScreenViewModel extends ChangeNotifier {
  final ResultRepository _resultRepository = ResultRepository();
  ResultInfoModel? _resultInfoModel;
  String _meetingId = '';
  String? _resultMessage;
  String? _inputErrorMessage;
  String? _resultState;
  bool _resultSuccess = false;
  DateTime _firstDate = DateTime.now();
  DateTime _lastDate = DateTime.utc(2030, 12, 31);
  DateTime _selectedDate = DateTime.now();
  int _countDates = 0;
  int _countTimes = 0;

  ResultInfoModel get resultInfoModel => _resultInfoModel!;
  String get meetingId => _meetingId;
  bool get resultSuccess => _resultSuccess;
  String? get resultMessage => _resultMessage;
  String? get resultState => _resultState;
  String? get inputErrorMessage => _inputErrorMessage;
  DateTime get firstDate => _firstDate;
  DateTime get lastDate => _lastDate;
  DateTime get selectedDate => _selectedDate;
  int get countDates => _countDates;
  int get countTimes => _countTimes;

  setMeetingId(String meetingId) {
    _meetingId = meetingId;
    notifyListeners();
  }

  Future<void> getResultInfo() async {
    var result = await _resultRepository.getResultInfo(_meetingId);
    if (result is Success) {
      _resultInfoModel = ResultInfoModel.fromJson(result.response);
      _firstDate = _resultInfoModel!.dateTimes.first.dateTime;
      _selectedDate = _firstDate;
      _lastDate = _resultInfoModel!.dateTimes.last.dateTime;
      _countDates = _lastDate.difference(_firstDate).inDays + 1;
      _countTimes = (_resultInfoModel!.dateTimes.length / _countDates).round();
      _resultSuccess = true;
      _resultMessage = null;
    } else if (result is Failure) {
      _resultSuccess = false;
      _resultMessage = result.errorResponse;
    }
  }
}
