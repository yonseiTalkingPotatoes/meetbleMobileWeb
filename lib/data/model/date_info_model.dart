class DateInfoModel {
  final DateTime date;
  final double totalScore;
  final int numberPossiblePeople;
  final int numberImpossiblePeople;
  final int numberUncertainPeople;
  final List<String> possiblePeople;
  final List<String> impossiblePeople;
  final List<String> uncertainPeople;

  DateInfoModel({
    required this.date,
    required this.totalScore,
    required this.numberPossiblePeople,
    required this.numberImpossiblePeople,
    required this.numberUncertainPeople,
    required this.possiblePeople,
    required this.impossiblePeople,
    required this.uncertainPeople,
  });
}