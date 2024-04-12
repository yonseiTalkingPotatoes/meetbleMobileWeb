import '../datasource/remote_datasource.dart';

class ResultRepository {
  final RemoteDataSource _remoteDataSource = RemoteDataSource();
  final String _result = "$meetbleApi/result";

  Future<Object> getResultInfo(String meetingId) async {
    return await _remoteDataSource.getFromUri("$_result/$meetingId");
  }
}
