import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:meetble/view/screens/create_screens/error_screen.dart';
import 'package:meetble/view/widgets/table_calander_widget/customization/calendar_builders.dart';
import 'package:meetble/view/widgets/table_calander_widget/customization/calendar_style.dart';
import 'package:meetble/view/widgets/table_calander_widget/customization/header_style.dart';
import 'package:meetble/view/widgets/table_calander_widget/shared/utils.dart';
import 'package:meetble/view_model/join_screens_view_model.dart';
import 'package:meetble/view_model/result_screen_view_model.dart';
import 'package:provider/provider.dart';
import '../../widgets/frame_screen_widget.dart';
import '../../widgets/notification_dialog_widget.dart';
import '../../widgets/table_calander_widget/table_calendar.dart';
import '../../widgets/time_picker_widget/time_picker_widget.dart';
import '../result_screen.dart';

class JoinScreen02 extends StatelessWidget {
  const JoinScreen02({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FrameScreenWidget(
      topWidget: Container(
        padding: EdgeInsets.only(top: 10),
        alignment: Alignment.centerLeft,
        child: Text(
          '${Provider.of<JoinScreensViewModel>(context, listen: false).userScheduleModel.userName} 님,\n상세 스케쥴을 등록해주세요!',
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.w700, fontSize: 15),
          textAlign: TextAlign.left,
        ),
      ),
      mainWidget: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StatefulBuilder(
            builder: (context, setState) {
              return TableCalendar(
                //locale: Localizations.localeOf(context).languageCode,
                locale: 'ko_KR',
                headerStyle: HeaderStyle(
                  titleTextFormatter: (date, locale) => DateFormat.yMd(locale).format(Provider.of<JoinScreensViewModel>(context).selectedDate),
                ),
                shortCutButtonVisible: false,
                firstDay: Provider.of<JoinScreensViewModel>(context, listen: false).firstDate,
                lastDay: Provider.of<JoinScreensViewModel>(context, listen: false).lastDate,
                calendarFormat: CalendarFormat.week,
                selectedDayPredicate: (dateTime) => Provider.of<JoinScreensViewModel>(context, listen: false).impossibleDates.contains(dateTime),
                focusedDay: Provider.of<JoinScreensViewModel>(context).selectedDate,
                onDaySelected: (DateTime selectedDay, DateTime focusedDay){
                  setState((){
                    Provider.of<JoinScreensViewModel>(context, listen: false).focusOnDate(selectedDay);
                  });
                },
                calendarStyle: CalendarStyle(
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
                      color: Color.fromRGBO(0, 0, 0, 1)
                  ),
                  weekendDecoration: BoxDecoration(
                    color: Color(0xFF9ACBF8),
                    shape: BoxShape.circle,
                  ),
                ),
                enabledDayPredicate: (dateTime) => Provider.of<JoinScreensViewModel>(context, listen: false).createModel.possibleDates.contains(dateTime),
              );
            }
          ),
          Container(
            padding: EdgeInsets.only(top: 15, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("images/jam_write.png",width: 17,height: 17,fit: BoxFit.contain,),
                Padding(
                  padding: EdgeInsets.only(left: 3),
                  child: Text(
                    "메모 작성하기",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF000000),
                      fontSize: 12
                    ),
                  ),
                ),
              ],
            ),
          ),
          TextField(
            controller: TextEditingController.fromValue(TextEditingValue(text: Provider.of<JoinScreensViewModel>(context).selectedDateStatus.memo, selection: TextSelection.collapsed(offset: (Provider.of<JoinScreensViewModel>(context, listen: false).selectedDateStatus.memo).length))),
            style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF000000)
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(11),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color(0xFF000000),
                      width: 1
                  ),
                  borderRadius: BorderRadius.circular(4)
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color(0xFF000000),
                      width: 1
                  ),
                  borderRadius: BorderRadius.circular(4)
              ),
              fillColor: Color(0xFFF4F4F4),
            ),
            maxLines: null,
            onChanged: (value) {
              Provider.of<JoinScreensViewModel>(context, listen: false).editMemo(value);
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(154, 203, 248, 1)
                  ),
                  width: 14,
                  height: 14,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                      '가능',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(0, 0, 0, 0.5)
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(255, 218, 124, 1)
                  ),
                  width: 14,
                  height: 14,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    '불확실',
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(0, 0, 0, 0.5)
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(255, 148, 148, 1)
                  ),
                  width: 14,
                  height: 14,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    '불가능',
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(0, 0, 0, 0.5)
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: StatefulBuilder(
              builder: (context, setState) {
                print("재빌드");
                print(Provider.of<JoinScreensViewModel>(context).selectedDateStatus.date);
                print(Provider.of<JoinScreensViewModel>(context).selectedDateStatus.timeBlock.first.statusCode);
                return TimePickerWidget(
                  //width: MediaQuery.of(context).size.width - 32,
                  width: 300,
                  timeRange: Provider.of<JoinScreensViewModel>(context, listen: false).createModel.possibleTimes,
                  timeStatusList: Provider.of<JoinScreensViewModel>(context).selectedDateStatus.timeBlock,
                  onTapTime: (int selectedTime) {
                    setState((){
                      Provider.of<JoinScreensViewModel>(context, listen: false).toggleTimeState(selectedTime);
                    });
                  },
                );
              },
            ),
          )
        ],
      ),
      index: 2,
      onTapNext: () async {
        FocusScope.of(context).unfocus();
        await Provider.of<JoinScreensViewModel>(context,listen: false).registerJoinInfo();
        print("화면 넘김 테스트1");
        Provider.of<JoinScreensViewModel>(context,listen: false).resultSuccess ?
        {
          await Provider.of<ResultScreenViewModel>(context,listen: false).setMeetingId(Provider.of<JoinScreensViewModel>(context, listen: false).userScheduleModel.id),
          print("화면 넘김 테스트2"),
          await Provider.of<ResultScreenViewModel>(context,listen: false).getResultInfo(),
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ResultScreen(meetingId: Provider.of<ResultScreenViewModel>(context,listen: false).meetingId,)), (route) => false)
        }
            :
        {
          showDialog(
              context: context,
              builder: (context){
                return NotificationDialogWidget(inputErrorMessage: Provider.of<JoinScreensViewModel>(context).resultMessage!, title: "입력이 올바르지 않습니다",);
              }
          ),
        };
      },
    );
  }
}
