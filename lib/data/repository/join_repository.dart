import 'package:meetble/data/model/user_schedule_model.dart';
import '../datasource/remote_datasource.dart';

class JoinRepository {
  final RemoteDataSource _remoteDataSource = RemoteDataSource();
  final String _join = "$meetbleApi/join";

  Future<Object> getMeetingInfo(String meetingId) async {
    return await _remoteDataSource.getFromUri("$_join/$meetingId");
  }

  Future<Object> saveJoinInfo(UserScheduleModel userScheduleModel) async {
    Map<String, dynamic> inputData = userScheduleModel.toJson();

    return await _remoteDataSource.postToUri(_join, inputData);
  }
}
