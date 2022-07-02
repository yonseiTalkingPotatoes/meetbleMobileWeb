import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Container(
                  alignment: Alignment.center,
                  width: 60,
                  height: 24,
                  color: Colors.green,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 31),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 1),
                        child: Text(
                          "모임을 편안하게,",
                          style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 21, fontWeight: FontWeight.w700),
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
                              style: Theme.of(context).textTheme.headlineLarge,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            "Meetble",
                            style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
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
                                style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "모임 일정 생성 및 수정",
                                style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 11),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                          Icon(Icons.chevron_right)
                        ],
                      ),
                    ),
                    onTap: (){},
                  ),
                ),
                Container(height: 31,),
                InkWell(
                  child: Text(
                    "서비스 문의하기",
                    style: Theme.of(context).textTheme.headlineSmall!,
                    textAlign: TextAlign.center,
                  ),
                  onTap: (){},
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}