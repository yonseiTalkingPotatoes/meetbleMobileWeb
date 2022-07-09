import 'package:flutter/material.dart';
import 'package:meetble/view_model/create_screens_view_model.dart';
import 'package:provider/provider.dart';

import '../../widgets/frame_screen_widget.dart';
import '../../widgets/notification_dialog_widget.dart';


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
      mainWidget: Container(),
      index: 2,
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
