import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class FrameScreenWidget extends StatelessWidget {
  final Widget topWidget;
  final Widget mainWidget;
  final double index;
  final GestureTapCallback? onTapNext;
  final Widget? customBottomButton;
  const FrameScreenWidget({Key? key, required this.topWidget, required this.mainWidget, required this.index, this.onTapNext, this.customBottomButton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("_FrameScreenWidgetState");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        toolbarHeight: 48,
        centerTitle: true,
        leading: IconButton(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          icon: Icon(
            Icons.chevron_left,
            color: Color(0xFF000000),
            size: 24,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Image.asset(
          "images/logo.png",
          height: 24,
          fit: BoxFit.contain,
        ),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              height: 78,
              padding: EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerLeft,
              child: topWidget
          ),
          Expanded(
            child: Container(
              height: 436,
              decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )
              ),
              padding: EdgeInsets.only(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                      color: Theme.of(context).backgroundColor,
                      child: mainWidget
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        DotsIndicator(
                          dotsCount: 4,
                          position: index,
                          decorator: DotsDecorator(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side: BorderSide(
                                    width: 1,
                                    color: Color(0xFF000000)
                                )
                            ),
                            size: const Size.square(10.0),
                            color: Colors.transparent,
                            activeColor: Color(0xFF000000),
                            activeSize: const Size(32.0, 10.0),
                            activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side: BorderSide(
                                    width: 1,
                                    color: Color(0xFF000000)
                                )
                            ),
                          ),
                        ),
                        customBottomButton ?? InkWell(
                          child: Container(
                            width: 145,
                            height: 37,
                            decoration: BoxDecoration(
                                color: Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.all(Radius.circular(32)),
                                border: Border.all(
                                    color: Color(0xFF000000),
                                    width: 1
                                )
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 24,
                                ),
                                Text(
                                  "다음",
                                  style: TextStyle(
                                    fontFamily: "Inter",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF000000),
                                    height: 1.5,
                                  ),
                                ),
                                Icon(Icons.chevron_right, size: 24,),
                              ],
                            ),
                          ),
                          onTap: onTapNext,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}