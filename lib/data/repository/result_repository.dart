import '../datasource/remote_datasource.dart';

class ResultRepository {
  final RemoteDataSource _remoteDataSource = RemoteDataSource();
  final String _result = "$MEETBLE_API/result";

  Future<Object> getResultInfo(String meetingId) async {
    print("getResultInfo");
    /*
    return Success(response: {
      'meeting_name': 'Meetble 개발',
      'count_people': 8,
      'count_joining_people': 6,
      'datetimes':
      [
        {
          'datetime': DateTime.utc(2022,08,02,12).toIso8601String(),
          'number_possible_people': 2,
          'number_impossible_people': 3,
          'number_uncertain_people': 1,
          'possible_people': ['인엽','건효'],
          'impossible_people': ['세모','지효','철수'],
          'uncertain_people': ['영희'],
        },
        {
          'datetime': DateTime.utc(2022,08,02,13).toIso8601String(),
          'number_possible_people': 2,
          'number_impossible_people': 2,
          'number_uncertain_people': 2,
          'possible_people': ['인엽','건효'],
          'impossible_people': ['세모','지효'],
          'uncertain_people': ['철수','영희'],
        },
        {
          'datetime': DateTime.utc(2022,08,02,14).toIso8601String(),
          'number_possible_people': 2,
          'number_impossible_people': 1,
          'number_uncertain_people': 3,
          'possible_people': ['인엽','건효'],
          'impossible_people': ['지효'],
          'uncertain_people': ['철수','영희','세모'],
        },
        {
          'datetime': DateTime.utc(2022,08,03,12).toIso8601String(),
          'number_possible_people': 2,
          'number_impossible_people': 3,
          'number_uncertain_people': 1,
          'possible_people': ['인엽','건효'],
          'impossible_people': ['세모','지효','철수'],
          'uncertain_people': ['영희'],
        },
        {
          'datetime': DateTime.utc(2022,08,03,13).toIso8601String(),
          'number_possible_people': 2,
          'number_impossible_people': 2,
          'number_uncertain_people': 2,
          'possible_people': ['인엽','건효'],
          'impossible_people': ['세모','지효'],
          'uncertain_people': ['철수','영희'],
        },
        {
          'datetime': DateTime.utc(2022,08,03,14).toIso8601String(),
          'number_possible_people': 2,
          'number_impossible_people': 2,
          'number_uncertain_people': 2,
          'possible_people': ['인엽','건효'],
          'impossible_people': ['지효'],
          'uncertain_people': ['철수','영희','세모'],
        },
        {
          'datetime': DateTime.utc(2022,08,04,12).toIso8601String(),
          'number_possible_people': 3,
          'number_impossible_people': 3,
          'number_uncertain_people': 0,
          'possible_people': ['인엽','건효'],
          'impossible_people': ['세모','지효','철수'],
          'uncertain_people': ['영희'],
        },
        {
          'datetime': DateTime.utc(2022,08,04,13).toIso8601String(),
          'number_possible_people': 6,
          'number_impossible_people': 0,
          'number_uncertain_people': 0,
          'possible_people': ['인엽','건효'],
          'impossible_people': ['세모','지효'],
          'uncertain_people': ['철수','영희'],
        },
        {
          'datetime': DateTime.utc(2022,08,04,14).toIso8601String(),
          'number_possible_people': 5,
          'number_impossible_people': 1,
          'number_uncertain_people': 0,
          'possible_people': ['인엽','건효'],
          'impossible_people': ['지효'],
          'uncertain_people': ['철수','영희','세모'],
        },
      ]
    });

     */
    return await _remoteDataSource.getFromUri("$_result/$meetingId");
  }
}