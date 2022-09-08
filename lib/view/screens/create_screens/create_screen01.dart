import 'package:flutter/material.dart';
import 'package:meetble/view_model/create_screens_view_model.dart';
import 'package:provider/provider.dart';

import '../../../data/datasource/local_datasource.dart';
import '../../widgets/frame_screen_widget.dart';
import '../../widgets/notification_dialog_widget.dart';
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
      mainWidget: StatefulBuilder(
        builder: (context, setState) {
          return TableCalendar(
            //locale: Localizations.localeOf(context).languageCode,
            locale: 'ko_KR',
            shortCutButtonVisible: true,
            firstDay: DateTime.now(),
            lastDay: DateTime.utc(2030, 12, 31),
            selectedDayPredicate: (dateTime) => Provider.of<CreateScreensViewModel>(context, listen: false).createInfo.possibleDates.contains(dateTime),
            focusedDay: Provider.of<CreateScreensViewModel>(context).selectedDate,
            onDaySelected: (DateTime selectedDay, DateTime focusedDay){
              setState((){
                Provider.of<CreateScreensViewModel>(context, listen: false).togglePossibleDates(selectedDay);
              });
            },
            onShortCutSelected: (){
              setState((){
                Provider.of<CreateScreensViewModel>(context, listen: false).resetPossibleDates();
              });
            },
            shortCutDate: DATE_SHORTCUT_LIST,
            eventLoader: (date) {
              return [DateTime.now()];
            },
          );
        }
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
              return NotificationDialogWidget(inputErrorMessage: Provider.of<CreateScreensViewModel>(context, listen: false).inputErrorMessage!, title: "입력이 올바르지 않습니다",);
            }
        );
      },
    );
  }
}
