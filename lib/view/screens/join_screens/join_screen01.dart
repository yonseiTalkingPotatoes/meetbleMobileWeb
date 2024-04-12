import 'package:flutter/material.dart';
import 'package:meetble/view/screens/join_screens/join_screen02.dart';
import 'package:meetble/view/widgets/table_calander_widget/customization/calendar_style.dart';
import 'package:meetble/view_model/join_screens_view_model.dart';
import 'package:provider/provider.dart';
import '../../widgets/frame_screen_widget.dart';
import '../../widgets/table_calander_widget/table_calendar.dart';

class JoinScreen01 extends StatelessWidget {
  const JoinScreen01({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FrameScreenWidget(
      topWidget: Container(
        padding: const EdgeInsets.only(top: 10),
        alignment: Alignment.centerLeft,
        child: Text(
          '${Provider.of<JoinScreensViewModel>(context, listen: false).userScheduleModel.userName} 님,\n안되는 날을 설정해주세요!',
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
              .copyWith(fontWeight: FontWeight.w700, fontSize: 15),
          textAlign: TextAlign.left,
        ),
      ),
      mainWidget: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StatefulBuilder(builder: (context, setState) {
            return TableCalendar(
              //locale: Localizations.localeOf(context).languageCode,
              locale: 'ko_KR',
              shortCutButtonVisible: false,
              firstDay:
                  Provider.of<JoinScreensViewModel>(context, listen: false)
                      .firstDate,
              lastDay: Provider.of<JoinScreensViewModel>(context, listen: false)
                  .lastDate,
              selectedDayPredicate: (dateTime) =>
                  Provider.of<JoinScreensViewModel>(context, listen: false)
                      .impossibleDates
                      .contains(dateTime),
              focusedDay:
                  Provider.of<JoinScreensViewModel>(context).selectedDate,
              onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                setState(() {
                  Provider.of<JoinScreensViewModel>(context, listen: false)
                      .toggleDateState(selectedDay);
                });
              },
              calendarStyle: const CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: Color(0xFFFF9494),
                  shape: BoxShape.circle,
                ),
                defaultDecoration: BoxDecoration(
                  color: Color(0xFF9ACBF8),
                  shape: BoxShape.circle,
                ),
                outsideDaysVisible: true,
                outsideDecoration: BoxDecoration(
                  color: Color(0xFF9ACBF8),
                  shape: BoxShape.circle,
                ),
                outsideTextStyle: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(0, 0, 0, 1)),
                weekendDecoration: BoxDecoration(
                  color: Color(0xFF9ACBF8),
                  shape: BoxShape.circle,
                ),
              ),
              enabledDayPredicate: (dateTime) =>
                  Provider.of<JoinScreensViewModel>(context, listen: false)
                      .createModel
                      .possibleDates
                      .contains(dateTime),
            );
          }),
          const Padding(
            padding: EdgeInsets.only(top: 15),
            child: Text(
              "날짜 가능 유무는 수정 가능합니다.",
              style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF000000),
                  fontSize: 12),
            ),
          )
        ],
      ),
      index: 1,
      onTapNext: () async {
        FocusScope.of(context).unfocus();
        Provider.of<JoinScreensViewModel>(context, listen: false)
            .updateImpossibleDates();
        Provider.of<JoinScreensViewModel>(context, listen: false)
            .focusOnFirstDate();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const JoinScreen02()));
      },
    );
  }
}
