import 'package:flutter/material.dart';
import 'package:meetble/view_model/create_screens_view_model.dart';
import 'package:provider/provider.dart';

import '../../widgets/frame_screen_widget.dart';
import 'create_screen01.dart';


class CreateScreen00 extends StatefulWidget {
  CreateScreen00({Key? key}) : super(key: key);

  @override
  State<CreateScreen00> createState() => _CreateScreen00State();
}

class _CreateScreen00State extends State<CreateScreen00> {
  late CreateScreensViewModel _createScreensViewModel;

  @override
  Widget build(BuildContext context) {
    _createScreensViewModel = Provider.of<CreateScreensViewModel>(context, listen: false);
    final _formKey = GlobalKey<FormState>();

    print("CreateScreen00");
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Form(
        child: FrameScreenWidget(
          topWidget: Text(
            '일정 생성하기',
            style: Theme.of(context).textTheme.headlineLarge!,
            textAlign: TextAlign.left,
          ),
          mainWidget: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
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
                      controller: TextEditingController.fromValue(TextEditingValue(text: _createScreensViewModel.createInfo.meetingName??"")),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await Provider.of<CreateScreensViewModel>(context, listen: false).increaseNum();
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
                        child: Consumer<CreateScreensViewModel>(
                          builder: (context, _createScreensViewModel, child) => TextFormField(
                            controller: TextEditingController.fromValue(TextEditingValue(text: _createScreensViewModel.createInfo.numberPeople.toString())),
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
                            onFieldSubmitted: (value) {
                              _formKey.currentState!.save();
                            },
                            validator: (value) {
                              _createScreensViewModel.checkNumberPeople(value??"");
                              if(!_createScreensViewModel.inputOk){
                                print(_createScreensViewModel.inputErrorMessage!);
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await Provider.of<CreateScreensViewModel>(context,listen: false).decreaseNum();
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
                )
              ],
            ),
          ),
          index: 0,
          onTapNext: () async {
            FocusScope.of(context).unfocus();
            await Provider.of<CreateScreensViewModel>(context,listen: false).checkInputOk();
            //await _createScreensViewModel.checkInputOk();
            Provider.of<CreateScreensViewModel>(context,listen: false).inputOk ?
            //_createScreensViewModel.inputOk ?
            //_userInfoViewModel.isUsernameOk ?
            {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CreateScreen01()))
            }
                :
            showDialog(
                context: context,
                builder: (context){
                  return SimpleDialog(
                    alignment: Alignment.center,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    title: Center(
                      child: Text(
                        "입력이 올바르지 않습니다",
                        style: TextStyle(
                            fontFamily: "Inter",
                            color: Color(0xFF000000),
                            fontSize: 16,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                    ),
                    children: <Widget>[
                      Center(
                        child: Text(
                          Provider.of<CreateScreensViewModel>(context, listen: false).inputErrorMessage!,
                          //_createScreensViewModel.inputErrorMessage!,
                          style: TextStyle(
                              fontFamily: "Inter",
                              color: Color(0xFF000000),
                              fontSize: 13,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Center(
                          child: IntrinsicWidth(
                            child: Text(
                              "확인",
                              style: TextStyle(
                                  fontFamily: "Inter",
                                  color: Color(0xFF000000),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                }
            );
          },
        ),
      ),
    );
  }
}