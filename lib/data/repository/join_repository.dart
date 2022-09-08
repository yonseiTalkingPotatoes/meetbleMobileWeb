import 'package:meetble/data/model/create_model.dart';
import 'package:meetble/data/model/user_schedule_model.dart';
import '../datasource/remote_datasource.dart';

class JoinRepository {
  final RemoteDataSource _remoteDataSource = RemoteDataSource();
  final String _join = "$MEETBLE_API/join";

  Future<Object> getMeetingInfo(String meetingId) async {
    print("getMeetingInfo");

    return await _remoteDataSource.getFromUri("$_join/$meetingId");
  }

  Future<Object> saveJoinInfo(UserScheduleModel userScheduleModel) async {
    print("saveUser");
    Map<String, dynamic> inputData = userScheduleModel.toJson();

    print(inputData);
    //return Success(response: {});
    return await _remoteDataSource.postToUri(_join, inputData);
  }


}