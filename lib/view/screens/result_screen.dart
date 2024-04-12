import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:meetble/data/datasource/remote_datasource.dart';
import 'package:meetble/view/screens/join_screens/join_screen00.dart';
import 'package:meetble/view_model/result_screen_view_model.dart';
import 'package:provider/provider.dart';
import '../../data/model/result_info_model.dart';
import '../widgets/notification_dialog_widget.dart';

class ResultScreen extends StatefulWidget {
  final String meetingId;
  const ResultScreen({Key? key, required this.meetingId}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FutureBuilder(
          future: _fetchResultInfo(),
          builder: (context, snapshot) {
            if (Provider.of<ResultScreenViewModel>(context).resultSuccess ==
                false) {
              return const Center(
                child: Text(
                  '결과 불러오는 중',
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                      color: Color(0xFFFFFFFF)),
                ),
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 78,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.only(top: 10),
                      alignment: Alignment.center,
                      child: Text(
                        '${Provider.of<ResultScreenViewModel>(context, listen: false).resultInfoModel.meetingName} 조율 결과',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(
                                fontWeight: FontWeight.w700, fontSize: 15),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              alignment: Alignment.centerRight,
                              margin: const EdgeInsets.only(bottom: 14),
                              child: Text(
                                '참여 인원 ${Provider.of<ResultScreenViewModel>(context, listen: false).resultInfoModel.countJoiningPeople}/${Provider.of<ResultScreenViewModel>(context).resultInfoModel.countPeople}',
                                style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(0, 0, 0, 0.6)),
                              ),
                            ),
                            Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Column(
                                  children: [
                                    for (int i = 0;
                                        i <
                                            Provider.of<ResultScreenViewModel>(
                                                    context,
                                                    listen: false)
                                                .countDates;
                                        i++)
                                      TimeHeatBox(
                                        dateResults: Provider.of<
                                                    ResultScreenViewModel>(
                                                context,
                                                listen: false)
                                            .resultInfoModel
                                            .dateTimes
                                            .sublist(
                                                Provider.of<ResultScreenViewModel>(
                                                            context)
                                                        .countTimes *
                                                    i,
                                                Provider.of<ResultScreenViewModel>(
                                                            context)
                                                        .countTimes *
                                                    (i + 1)),
                                        countJoiningPeople:
                                            Provider.of<ResultScreenViewModel>(
                                                    context,
                                                    listen: false)
                                                .resultInfoModel
                                                .countJoiningPeople,
                                        onTap: () {},
                                      )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Flexible(flex: 1, child: Container()),
                                        const Flexible(
                                          flex: 10,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                '12AM',
                                                style: TextStyle(
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 6,
                                                    color: Color.fromRGBO(
                                                        83, 98, 116, 1)),
                                              ),
                                              Text(
                                                '6AM',
                                                style: TextStyle(
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 8,
                                                    color: Color.fromRGBO(
                                                        83, 98, 116, 1)),
                                              ),
                                              Text(
                                                '12PM',
                                                style: TextStyle(
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 8,
                                                    color: Color.fromRGBO(
                                                        83, 98, 116, 1)),
                                              ),
                                              Text(
                                                '6PM',
                                                style: TextStyle(
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 8,
                                                    color: Color.fromRGBO(
                                                        83, 98, 116, 1)),
                                              ),
                                              Text(
                                                '12AM',
                                                style: TextStyle(
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 6,
                                                    color: Color.fromRGBO(
                                                        83, 98, 116, 1)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8 +
                                          Provider.of<ResultScreenViewModel>(
                                                      context,
                                                      listen: false)
                                                  .countDates *
                                              36,
                                      child: Row(
                                        children: [
                                          Flexible(
                                            flex: 2,
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                      right: BorderSide(
                                                          color:
                                                              Color(0xFF536274),
                                                          width: 0.35))),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 5,
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                      left: BorderSide(
                                                          color:
                                                              Color(0xFF536274),
                                                          width: 0.35),
                                                      right: BorderSide(
                                                          color:
                                                              Color(0xFF536274),
                                                          width: 0.35))),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 5,
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                      left: BorderSide(
                                                          color:
                                                              Color(0xFF536274),
                                                          width: 0.35),
                                                      right: BorderSide(
                                                          color:
                                                              Color(0xFF536274),
                                                          width: 0.35))),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 5,
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                      left: BorderSide(
                                                          color:
                                                              Color(0xFF536274),
                                                          width: 0.35),
                                                      right: BorderSide(
                                                          color:
                                                              Color(0xFF536274),
                                                          width: 0.35))),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 5,
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                      left: BorderSide(
                                                          color:
                                                              Color(0xFF536274),
                                                          width: 0.35),
                                                      right: BorderSide(
                                                          color:
                                                              Color(0xFF536274),
                                                          width: 0.7))),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        DotsIndicator(
                          dotsCount: 4,
                          position: 3,
                          decorator: DotsDecorator(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side: const BorderSide(
                                    width: 1, color: Color(0xFF000000))),
                            size: const Size.square(10.0),
                            color: Colors.transparent,
                            activeColor: const Color(0xFF000000),
                            activeSize: const Size(32.0, 10.0),
                            activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side: const BorderSide(
                                    width: 1, color: Color(0xFF000000))),
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: InkWell(
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Icon(
                                        Icons.people,
                                        size: 24,
                                      ),
                                    ),
                                    Text(
                                      "참여하기",
                                      style: TextStyle(
                                          fontFamily: "Inter",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF000000),
                                          height: 1.2),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => JoinScreen00(
                                              meetingId: Provider.of<
                                                          ResultScreenViewModel>(
                                                      context)
                                                  .meetingId)));
                                },
                              ),
                            ),
                            InkWell(
                              child: Container(
                                width: 145,
                                height: 37,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF88D4FF),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(24)),
                                    border: Border.all(
                                        color: const Color(0xFF000000),
                                        width: 1)),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Icon(
                                        Icons.upload_rounded,
                                        size: 24,
                                      ),
                                    ),
                                    Text(
                                      "공유하기",
                                      style: TextStyle(
                                          fontFamily: "Inter",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF000000),
                                          height: 1.2),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return NotificationDialogWidget(
                                        inputErrorMessage:
                                            "$meetble/result/${Provider.of<ResultScreenViewModel>(context).meetingId}",
                                        title: '링크가 복사되었습니다',
                                      );
                                    });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              );
            }
          }),
    );
  }

  Future<void> _fetchResultInfo() async {
    if (Provider.of<ResultScreenViewModel>(context).resultSuccess == false) {
      await Provider.of<ResultScreenViewModel>(context, listen: false)
          .setMeetingId(widget.meetingId);
      await Provider.of<ResultScreenViewModel>(context, listen: false)
          .getResultInfo();
    }
  }
}

class TimeHeatBox extends StatelessWidget {
  final List<DateResultModel> dateResults;
  final int countJoiningPeople;
  final GestureTapCallback onTap;
  final List<String> days = ['월', '화', '수', '목', '금', '토', '일'];
  TimeHeatBox(
      {Key? key,
      required this.dateResults,
      required this.countJoiningPeople,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
            border: Border.all(color: const Color(0xFF000000), width: 0.7),
            color: const Color(0xFFFFFFFF)),
        height: 36,
        child: Row(
          children: [
            Flexible(
              flex: 12,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFFFE39C),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.zero,
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.zero),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${dateResults.first.dateTime.month}.${dateResults.first.dateTime.day}',
                      style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 7.5,
                          color: Color(0xFF000000)),
                    ),
                    Text(days[dateResults.first.dateTime.weekday - 1],
                        style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                            color: Color(0xFF000000)))
                  ],
                ),
              ),
            ),
            for (int i = 1; i < 25; i++)
              Flexible(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                    border: const Border(
                        left: BorderSide(
                            color: Color.fromRGBO(99, 116, 136, 0.5),
                            width: 0.25),
                        right: BorderSide(
                            color: Color.fromRGBO(99, 116, 136, 0.5),
                            width: 0.25)),
                    color: i >= dateResults.first.dateTime.hour &&
                            i <= dateResults.last.dateTime.hour
                        ? countJoiningPeople > 0
                            ? const Color(0xFF49A8FF).withOpacity((dateResults[
                                            i - dateResults.first.dateTime.hour]
                                        .numberPossiblePeople +
                                    dateResults[i -
                                                dateResults.first.dateTime.hour]
                                            .numberUncertainPeople *
                                        0.5) /
                                countJoiningPeople)
                            : const Color(0xFFFFFFFF)
                        : const Color(0xFFE5E5E5),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
