import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meetble/view/screens/join_screens/join_screen00.dart';
import 'package:meetble/view/widgets/frame_screen_widget.dart';
import 'package:provider/provider.dart';

import '../../../data/datasource/remote_datasource.dart';
import '../../../fluro_router.dart';
import '../../../view_model/create_screens_view_model.dart';
import '../../widgets/notification_dialog_widget.dart';
import '../../widgets/table_calander_widget/table_calendar.dart';

class CreateScreen03 extends StatelessWidget {
  const CreateScreen03({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FrameScreenWidget(
      topWidget: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              Provider.of<CreateScreensViewModel>(context)
                  .createInfo
                  .meetingName,
              style: const TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w700,
                fontSize: 15,
                color: Color(0xFF000000),
              ),
            ),
            const Text(
              "회의 생성이 완료되었습니다.",
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w700,
                fontSize: 15,
                color: Color(0xFF000000),
              ),
            ),
          ],
        ),
      ),
      mainWidget: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StatefulBuilder(builder: (context, setState) {
            return TableCalendar(
              locale: 'ko_KR',
              shortCutButtonVisible: false,
              firstDay: DateTime.now(),
              lastDay: DateTime.utc(2030, 12, 31),
              selectedDayPredicate: (dateTime) =>
                  Provider.of<CreateScreensViewModel>(context, listen: false)
                      .createInfo
                      .possibleDates
                      .contains(dateTime),
              focusedDay:
                  Provider.of<CreateScreensViewModel>(context).selectedDate,
              eventLoader: (date) {
                return [DateTime.now()];
              },
            );
          }),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Container(
              height: 72,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFF000000),
                  width: 0.7,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "참여 인원",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF000000),
                        ),
                      ),
                      Text(
                        "${Provider.of<CreateScreensViewModel>(context).createInfo.countPeople}명",
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF000000),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "시간 구간",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF000000),
                        ),
                      ),
                      Text(
                        "${Provider.of<CreateScreensViewModel>(context).createInfo.possibleTimes.reduce((curr, next) => curr < next ? curr : next)}시 ~ ${Provider.of<CreateScreensViewModel>(context).createInfo.possibleTimes.reduce((curr, next) => curr > next ? curr : next)}시",
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF000000),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            child: const Text(
              "일정 정보 수정하기",
              style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: Color(0xFF2B689B),
                  height: 1.2),
              textAlign: TextAlign.center,
            ),
            onTap: () {
              FRouter.router.navigateTo(context, FRouter.create);
            },
          )
        ],
      ),
      index: 3,
      customBottomButton: Column(
        children: [
          InkWell(
            child: Container(
              width: 145,
              height: 37,
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.all(Radius.circular(24)),
                  border: Border.all(color: const Color(0xFF000000), width: 1)),
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
              Clipboard.setData(ClipboardData(
                  text:
                      '$meetble/result/${Provider.of<CreateScreensViewModel>(context, listen: false).createInfo.id}'));
              showDialog(
                  context: context,
                  builder: (context) {
                    return const NotificationDialogWidget(
                      inputErrorMessage: "",
                      title: "링크가 복사되었습니다",
                    );
                  });
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: InkWell(
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "내 스케줄 입력하기 ",
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: Color(0xFF2B689B),
                        height: 1.2),
                    textAlign: TextAlign.center,
                  ),
                  Icon(
                    Icons.arrow_forward,
                    size: 24,
                  ),
                ],
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return JoinScreen00(
                          meetingId:
                              Provider.of<CreateScreensViewModel>(context)
                                  .createInfo
                                  .id);
                    });
              },
            ),
          )
        ],
      ),
    );
  }
}
