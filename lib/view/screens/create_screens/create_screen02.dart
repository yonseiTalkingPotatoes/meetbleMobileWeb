import 'package:flutter/material.dart';
import 'package:meetble/view/widgets/time_picker_widget/time_picker_widget.dart';
import 'package:meetble/view_model/create_screens_view_model.dart';
import 'package:provider/provider.dart';
import '../../../data/datasource/local_datasource.dart';
import '../../widgets/frame_screen_widget.dart';
import '../../widgets/notification_dialog_widget.dart';
import 'create_screen03.dart';

class CreateScreen02 extends StatelessWidget {
  const CreateScreen02({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FrameScreenWidget(
      topWidget: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${Provider.of<CreateScreensViewModel>(context).createInfo.meetingName}의',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontWeight: FontWeight.w700, fontSize: 15),
              textAlign: TextAlign.left,
            ),
            Text(
              '시간 구간을 설정해주세요!',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontWeight: FontWeight.w700, fontSize: 15),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
      mainWidget: StatefulBuilder(builder: (context, setState) {
        return TimePickerWidget(
          width: 300,
          shortCutTime: timeShortcutList,
          timeRange: Provider.of<CreateScreensViewModel>(context)
              .createInfo
              .possibleTimes,
          resetSelectedTime: () {
            setState(() {
              Provider.of<CreateScreensViewModel>(context, listen: false)
                  .resetPossibleTimes();
            });
          },
          onTapTime: (int selectedTime) {
            setState(() {
              Provider.of<CreateScreensViewModel>(context, listen: false)
                  .togglePossibleTimes(selectedTime);
            });
          },
        );
      }),
      index: 2,
      onTapNext: () async {
        FocusScope.of(context).unfocus();
        await Provider.of<CreateScreensViewModel>(context, listen: false)
            .checkThirdScreenInputOk();
        Provider.of<CreateScreensViewModel>(context, listen: false).inputOk
            ? {
                await Provider.of<CreateScreensViewModel>(context,
                        listen: false)
                    .getMeetingId(),
                Provider.of<CreateScreensViewModel>(context, listen: false)
                        .resultSuccess
                    ? {
                        Provider.of<CreateScreensViewModel>(context,
                                listen: false)
                            .registerMeeting(),
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CreateScreen03()),
                            (route) => false)
                      }
                    : {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return NotificationDialogWidget(
                                inputErrorMessage:
                                    Provider.of<CreateScreensViewModel>(context)
                                        .resultMessage!,
                                title: "입력이 올바르지 않습니다",
                              );
                            }),
                      }
              }
            : showDialog(
                context: context,
                builder: (context) {
                  return NotificationDialogWidget(
                    inputErrorMessage:
                        Provider.of<CreateScreensViewModel>(context)
                            .inputErrorMessage!,
                    title: "입력이 올바르지 않습니다",
                  );
                });
      },
    );
  }
}
