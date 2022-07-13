import 'package:flutter/material.dart';
import 'package:meetble/view/widgets/time_picker_widget/time_picker_widget.dart';
import 'package:meetble/view_model/create_screens_view_model.dart';
import 'package:provider/provider.dart';
import '../../widgets/frame_screen_widget.dart';
import '../../widgets/notification_dialog_widget.dart';
import '../../widgets/pie_timer_widget/pie_timer_widget.dart';
import 'create_screen03.dart';


class CreateScreen02 extends StatelessWidget {
  const CreateScreen02({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("CreateScreen02");
    return FrameScreenWidget(
      topWidget: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${Provider.of<CreateScreensViewModel>(context).createInfo.meetingName}의',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.w700, fontSize: 15),
              textAlign: TextAlign.left,
            ),
            Text(
              '시간 구간을 설정해주세요!',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.w700, fontSize: 15),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
      mainWidget: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: StatefulBuilder(
          builder: (context, setState) {
            return TimePickerWidget(
              width: MediaQuery.of(context).size.width - 20,
              shortCutTime: Provider.of<CreateScreensViewModel>(context).timeRange,
              timeRange: Provider.of<CreateScreensViewModel>(context).createInfo.timeRange,
              resetSelectedTime: () {
                setState((){
                  Provider.of<CreateScreensViewModel>(context, listen: false).resetPossibleTimes();
                });
              },
              onTapTime: (int selectedTime) {
                setState((){
                  Provider.of<CreateScreensViewModel>(context, listen: false).toggleTimeState(selectedTime);
                });
              },
            );
          }
        ),
      ),
      index: 2,
      onTapNext: () async {
        FocusScope.of(context).unfocus();
        await Provider.of<CreateScreensViewModel>(context,listen: false).checkThirdScreenInputOk();
        Provider.of<CreateScreensViewModel>(context,listen: false).inputOk ?
        {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateScreen03()))
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
