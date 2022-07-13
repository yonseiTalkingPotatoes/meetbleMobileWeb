import 'package:flutter/material.dart';
import 'package:meetble/view/widgets/frame_screen_widget.dart';
import 'package:provider/provider.dart';

import '../../../view_model/create_screens_view_model.dart';
import '../../widgets/notification_dialog_widget.dart';
import '../../widgets/table_calander_widget/customization/calendar_style.dart';
import '../../widgets/table_calander_widget/customization/days_of_week_style.dart';
import '../../widgets/table_calander_widget/customization/header_style.dart';
import '../../widgets/table_calander_widget/shared/utils.dart';
import '../../widgets/table_calander_widget/table_calendar.dart';

class CreateScreen03 extends StatelessWidget {
  const CreateScreen03({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("CreateScreen02");
    return FrameScreenWidget(
      topWidget: Center(
        child: Text(
          "${Provider.of<CreateScreensViewModel>(context).createInfo.meetingName}\n회의 생성이 완료되었습니다.",
          style: TextStyle(
            fontFamily: "Inter",
            fontWeight: FontWeight.w700,
            fontSize: 15,
            color: Color(0xFF000000),
          ),
        ),
      ),
      mainWidget: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StatefulBuilder(
                builder: (context, setState) {
                  return TableCalendar(
                    locale: 'ko_KR',
                    shortCutButtonVisible: false,
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
                    shortCutDate: [],
                  );
                }
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Container(
                height: 72,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFF000000),
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
                        Text(
                          "참여 인원",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF000000),
                          ),
                        ),
                        Text(
                          "${Provider.of<CreateScreensViewModel>(context).createInfo.numberPeople}명",
                          style: TextStyle(
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
                        Text(
                          "시간 구간",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF000000),
                          ),
                        ),
                        Text(
                          "${Provider.of<CreateScreensViewModel>(context).createInfo.timeRange.reduce((curr, next) => curr < next? curr: next)}시 ~ ${Provider.of<CreateScreensViewModel>(context).createInfo.timeRange.reduce((curr, next) => curr > next? curr: next)}시",
                          style: TextStyle(
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
              child: Text(
                "회의 정보 수정하기",
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: Color(0xFF2B689B),
                    height: 1.2
                ),
                textAlign: TextAlign.center,
              ),
              onTap: (){
                showDialog(
                    context: context,
                    builder: (context){
                      return NotificationDialogWidget(inputErrorMessage: "향후 서비스 지원 예정");
                    }
                );
              },
            )
          ],
        ),
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
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                  border: Border.all(
                      color: Color(0xFF000000),
                      width: 1
                  )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(Icons.upload_rounded, size: 24,),
                  ),
                  Text(
                    "공유하기",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF000000),
                      height: 1.2
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            onTap: (){
              showDialog(
                  context: context,
                  builder: (context){
                    return NotificationDialogWidget(inputErrorMessage: "링크 공유 서비스 지원 예정");
                  }
              );
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 12),
            child: InkWell(
              child: Row(
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
                      height: 1.2
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Icon(Icons.arrow_forward, size: 24,),
                ],
              ),
              onTap: (){
                showDialog(
                    context: context,
                    builder: (context){
                      return NotificationDialogWidget(inputErrorMessage: "향후 서비스 지원 예정");
                    }
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
