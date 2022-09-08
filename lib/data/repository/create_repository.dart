import 'package:meetble/data/model/create_model.dart';

import '../datasource/remote_datasource.dart';

class CreateRepository {
  final RemoteDataSource _remoteDataSource = RemoteDataSource();
  final String _meet = "$MEETBLE_API/meet";

  Future<Object> getNewMeetingId(String meetingName) async {
    print("getNewMeetingId");
    Map<String, dynamic> inputData = {
      "meeting_name": meetingName,
    };

    /*
    return Success(response: {
      "meeting_id": "dfafa#!lCOdfdaf",
    });

     */
    print("확인1");
    return await _remoteDataSource.postToUri(_meet, inputData);
  }

  Future<Object> saveMeetingInfo(CreateModel createModel) async {
    print("saveMeetingInfo");
    Map<String, dynamic> inputData = createModel.toJson();
    print(inputData);
    
    //return Success(response: {});
    return await _remoteDataSource.putToUri(_meet, inputData);
  }
}