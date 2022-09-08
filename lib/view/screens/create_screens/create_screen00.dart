import 'package:flutter/material.dart';
import 'package:meetble/view_model/create_screens_view_model.dart';
import 'package:provider/provider.dart';

import '../../widgets/frame_screen_widget.dart';
import '../../widgets/notification_dialog_widget.dart';
import 'create_screen01.dart';


class CreateScreen00 extends StatefulWidget {
  CreateScreen00({Key? key}) : super(key: key);

  @override
  State<CreateScreen00> createState() => _CreateScreen00State();
}

class _CreateScreen00State extends State<CreateScreen00> {
  @override
  Widget build(BuildContext context) {

    print("CreateScreen00");
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
                  '일정 생성하기',
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
                    "모임 제목",
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 15)
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 41),
                child: Consumer<CreateScreensViewModel>(
                  builder: (context, _createScreenViewModel, child) => TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    controller: TextEditingController.fromValue(TextEditingValue(text: Provider.of<CreateScreensViewModel>(context, listen: false).createInfo.meetingName, selection: TextSelection.collapsed(offset: (Provider.of<CreateScreensViewModel>(context, listen: false).createInfo.meetingName).length))),
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
                    maxLength: 16,
                    onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
                    validator: (value) {
                      Provider.of<CreateScreensViewModel>(context, listen: false).checkMeetingName(value??"");
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 17),
                child: Text(
                    "모임 인원수",
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 15)
                ),
              ),
              StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState){
                    print("NumberPicker");
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() async {
                              await Provider.of<CreateScreensViewModel>(context, listen: false).increaseNum();
                            });
                          },
                          child: Icon(Icons.add, size: 16, color: Color(0xFF000000),),
                          style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              primary: Color(0xFFD9D9D9),
                              onPrimary: Color(0xFFD9D9D9),
                              fixedSize: Size.square(26)
                          ),
                        ),
                        Container(
                          height: 47,
                          width: 96,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xFF000000),
                                width: 0.7
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: IntrinsicWidth(
                            child: TextFormField(
                              controller: TextEditingController.fromValue(TextEditingValue(text: Provider.of<CreateScreensViewModel>(context).createInfo.countPeople.toString(), selection: TextSelection.collapsed(offset: Provider.of<CreateScreensViewModel>(context).createInfo.countPeople.toString().length))),
                              autovalidateMode: AutovalidateMode.always,
                              style: TextStyle(
                                  fontFamily: "Inter",
                                  color: Color(0xFF000000),
                                  fontSize: 33,
                                  fontWeight: FontWeight.w700
                              ),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  suffixText: '명',
                                  suffixStyle: TextStyle(
                                      fontFamily: "Inter",
                                      color: Color(0xFF000000),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700
                                  ),
                                  contentPadding: EdgeInsets.zero
                              ),
                              textAlign: TextAlign.end,
                              maxLines: 1,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                Provider.of<CreateScreensViewModel>(context).checkNumberPeople(value??"");
                              },
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() async {
                              await Provider.of<CreateScreensViewModel>(context, listen: false).decreaseNum();
                            });
                          },
                          child: Icon(Icons.remove, size: 16, color: Color(0xFF000000),),
                          style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              primary: Color(0xFFD9D9D9),
                              onPrimary: Color(0xFFD9D9D9),
                              fixedSize: Size.square(26)
                          ),
                        ),
                      ],
                    );
                  }
              ),
            ],
          ),
          index: 0,
          onTapNext: () async {
            FocusScope.of(context).unfocus();
            await Provider.of<CreateScreensViewModel>(context,listen: false).checkFirstScreenInputOk();
            Provider.of<CreateScreensViewModel>(context,listen: false).inputOk ?
            {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CreateScreen01()))
            }
                :
            showDialog(
                context: context,
                builder: (context){
                  return NotificationDialogWidget(inputErrorMessage: Provider.of<CreateScreensViewModel>(context, listen: false).inputErrorMessage!, title: "입력이 올바르지 않습니다",);
                }
            );
          },
        ),
      ),
    );
  }
}