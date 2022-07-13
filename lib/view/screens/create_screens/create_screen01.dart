import 'package:flutter/material.dart';
import 'package:meetble/view/widgets/table_calander_widget/customization/header_style.dart';
import 'package:meetble/view_model/create_screens_view_model.dart';
import 'package:provider/provider.dart';

import '../../widgets/frame_screen_widget.dart';
import '../../widgets/notification_dialog_widget.dart';
import '../../widgets/table_calander_widget/customization/calendar_style.dart';
import '../../widgets/table_calander_widget/customization/days_of_week_style.dart';
import '../../widgets/table_calander_widget/shared/utils.dart';
import '../../widgets/table_calander_widget/table_calendar.dart';
import 'create_screen02.dart';

class CreateScreen01 extends StatelessWidget {
  const CreateScreen01({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("CreateScreen01");
    return FrameScreenWidget(
      topWidget: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '가능한 날짜를 모두 선택해주세요!',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.w700, fontSize: 15),
              textAlign: TextAlign.left,
            ),
            Text(
              '원하는 날짜를 터치, 드래그해서 선택해봐요 :)',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.w400, fontSize: 13),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
      mainWidget: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: StatefulBuilder(
          builder: (context, setState) {
            return TableCalendar(
              //locale: Localizations.localeOf(context).languageCode,
              locale: 'ko_KR',
              headerStyle: HeaderStyle(
                titleCentered: true,
                titleTextStyle: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF000000)
                ),
                formatButtonVisible: false,
                formatButtonShowsNext: false,
                headerPadding: EdgeInsets.zero,
                headerMargin: EdgeInsets.zero,
                leftChevronPadding: EdgeInsets.zero,
                rightChevronPadding: EdgeInsets.zero,
                leftChevronMargin: EdgeInsets.only(right: 13),
                rightChevronMargin: EdgeInsets.only(left: 13)
              ),
              firstDay: DateTime.now(),
              lastDay: DateTime.utc(2030, 12, 31),
              dayHitTestBehavior: HitTestBehavior.translucent,
              selectedDayPredicate: (dateTime) => Provider.of<CreateScreensViewModel>(context, listen: false).createInfo.possibleDates.contains(dateTime),
              rangeSelectionMode: RangeSelectionMode.toggledOn,
              focusedDay: Provider.of<CreateScreensViewModel>(context).selectedDate,
              rowHeight: 36,
              onDaySelected: (DateTime selectedDay, DateTime focusedDay){
                setState((){
                  Provider.of<CreateScreensViewModel>(context, listen: false).toggleDateState(selectedDay);
                });
              },
              onShortCutSelected: (){
                setState((){
                  Provider.of<CreateScreensViewModel>(context, listen: false).resetPossibleDates();
                });
              },
              startingDayOfWeek: StartingDayOfWeek.monday,
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF000000),
                ),
                weekendStyle: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF000000),
                ),
                decoration: BoxDecoration(
                  color: Color(0xFF000000).withOpacity(0.1),
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xFF000000),
                      width: 0.7
                    )
                  ),
                )
              ),
              daysOfWeekHeight: 19,
              eventLoader: (date) {
                return [DateTime.now()];
              },
              calendarStyle: CalendarStyle(
                isTodayHighlighted: false,
                cellMargin: EdgeInsets.symmetric(vertical: 6),
                rowDecoration: BoxDecoration(
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      width: 0.4,
                      color: Color(0xFF000000).withOpacity(0.7)
                    )
                  )
                ),
                markerDecoration: BoxDecoration(
                  color: Color(0xFF000000),
                  shape: BoxShape.circle
                ),
                markerSize: 3,
                markersAutoAligned: false,
                markersOffset: PositionedOffset(top: 8),
                calendarDecoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                        color: Color(0xFF000000),
                        width: 0.7
                    )
                ),
                defaultTextStyle: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF000000),
                ),
                weekendTextStyle: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF000000),
                ),
                todayTextStyle: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF000000),
                ),
                disabledTextStyle: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF000000).withOpacity(0.3),
                ),
                selectedTextStyle: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF000000),
                ),
                outsideTextStyle: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF000000).withOpacity(0.3),
                ),
                selectedDecoration: BoxDecoration(
                  color: Color(0xFF9ACBF8),
                  shape: BoxShape.circle,
                ),
              ),
              shortCutDate: Provider.of<CreateScreensViewModel>(context).dateRanges,
            );
          }
        ),
      ),
      index: 1,
      onTapNext: () async {
        FocusScope.of(context).unfocus();
        await Provider.of<CreateScreensViewModel>(context,listen: false).checkSecondScreenInputOk();
        Provider.of<CreateScreensViewModel>(context,listen: false).inputOk ?
        {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateScreen02()))
        }
            :
        showDialog(
            context: context,
            builder: (context){
              return NotificationDialogWidget(inputErrorMessage: Provider.of<CreateScreensViewModel>(context).inputErrorMessage!,);
            }
        );
      },
    );
  }
}
