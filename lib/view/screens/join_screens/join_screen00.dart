import 'package:flutter/material.dart';
import 'package:meetble/view/screens/create_screens/error_screen.dart';
import 'package:meetble/view/screens/join_screens/join_screen01.dart';
import 'package:meetble/view_model/join_screens_view_model.dart';
import 'package:provider/provider.dart';

import '../../widgets/frame_screen_widget.dart';
import '../../widgets/notification_dialog_widget.dart';


class JoinScreen00 extends StatefulWidget {
  final String meetingId;
  JoinScreen00({Key? key, required this.meetingId}) : super(key: key);

  @override
  State<JoinScreen00> createState() => _JoinScreen00State();
}

class _JoinScreen00State extends State<JoinScreen00> {
  @override
  Widget build(BuildContext context) {
    print("JoinScreen00");
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Form(
        child: FrameScreenWidget(
          topWidget: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '일정 참여하기',
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
          mainWidget: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 17),
                child: Text(
                    "닉네임을 입력하세요",
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 15)
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 41),
                child: Consumer<JoinScreensViewModel>(
                  builder: (context, _createScreenViewModel, child) => TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    controller: TextEditingController.fromValue(TextEditingValue(text: Provider.of<JoinScreensViewModel>(context, listen: false).userScheduleModel.userName, selection: TextSelection.collapsed(offset: (Provider.of<JoinScreensViewModel>(context, listen: false).userScheduleModel.userName).length))),
                    style: Theme.of(context).textTheme.bodyText1,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 0.7,
                          color: Color(0xFF000000),
                        ),
                      ),
                    ),
                    maxLines: 1,
                    maxLength: 8,
                    onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
                    validator: (value) {
                      Provider.of<JoinScreensViewModel>(context, listen: false).checkUserName(value??"");
                    },
                  ),
                ),
              ),
            ],
          ),
          index: 0,
          onTapNext: () async {
            FocusScope.of(context).unfocus();
            await Provider.of<JoinScreensViewModel>(context,listen: false).checkFirstScreenInputOk();
            Provider.of<JoinScreensViewModel>(context,listen: false).inputOk ?
            {
              await Provider.of<JoinScreensViewModel>(context,listen: false).getMeetingInfo(widget.meetingId),
              Provider.of<JoinScreensViewModel>(context,listen: false).resultSuccess ?
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => JoinScreen01()))
              }
                  :
              {
                showDialog(
                    context: context,
                    builder: (context){
                      return NotificationDialogWidget(inputErrorMessage: Provider.of<JoinScreensViewModel>(context).resultMessage!, title: "입력이 올바르지 않습니다",);
                    }
                ),
              }
            }
                :
            showDialog(
                context: context,
                builder: (context){
                  return NotificationDialogWidget(inputErrorMessage: Provider.of<JoinScreensViewModel>(context).inputErrorMessage!, title: "입력이 올바르지 않습니다",);
                }
            );
          },
        ),
      ),
    );
  }
}