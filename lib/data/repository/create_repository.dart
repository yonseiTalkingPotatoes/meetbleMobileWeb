import 'package:meetble/data/model/create_model.dart';
import '../datasource/remote_datasource.dart';

class CreateRepository {
  final RemoteDataSource _remoteDataSource = RemoteDataSource();
  final String _meet = "$meetbleApi/meet";

  Future<Object> getNewMeetingId(String meetingName) async {
    Map<String, dynamic> inputData = {
      "meeting_name": meetingName,
    };
    return await _remoteDataSource.postToUri(_meet, inputData);
  }

  Future<Object> saveMeetingInfo(CreateModel createModel) async {
    Map<String, dynamic> inputData = createModel.toJson();

    return await _remoteDataSource.putToUri(_meet, inputData);
  }
}
