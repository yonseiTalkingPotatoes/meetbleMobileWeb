import 'package:flutter/material.dart';

import '../../fluro_router.dart';
import 'create_screens/create_screen00.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("HomeScreen");
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: Container(
        color: Theme.of(context).backgroundColor,
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 1),
                      child: Text(
                        "모임을 편안하게,",
                        style: TextStyle(
                          fontFamily: "Pretendard",
                          fontSize: 21,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF000000),
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: Text(
                            "밋블",
                            style: TextStyle(
                              fontFamily: "Pretendard",
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF000000),
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          "Meetble",
                          style: TextStyle(
                            fontFamily: "Nunito",
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF000000),
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 80, left: 50),
                  child: Image.asset(
                    "images/main_logo.png",
                    height: 100,
                    fit: BoxFit.fitHeight,
                  ),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    child: Container(
                      height: 63,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 0.7,
                            color: Color(0xFF000000),
                          ),
                          color: Theme.of(context).scaffoldBackgroundColor
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "지금 시작하기",
                                style:TextStyle(
                                  fontFamily: "Pretendard",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF000000),
                                  height: 1.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "모임 일정 생성 및 수정",
                                style: TextStyle(
                                  fontFamily: "Pretendard",
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF5C5C5C),
                                  height: 1.5,
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                          Icon(Icons.chevron_right)
                        ],
                      ),
                    ),
                    onTap: (){
                      FRouter.router.navigateTo(context, FRouter.create);
                    },
                  ),
                ),
                Container(height: 31,),
                InkWell(
                  child: Text(
                    "서비스 문의하기",
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF5C5C5C)
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onTap: (){
                    FRouter.router.navigateTo(context, FRouter.meet.replaceAll(":id", "1"));
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}