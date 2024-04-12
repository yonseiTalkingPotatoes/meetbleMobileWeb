import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class FrameScreenWidget extends StatelessWidget {
  final Widget topWidget;
  final Widget mainWidget;
  final double index;
  final GestureTapCallback? onTapNext;
  final Widget? customBottomButton;
  const FrameScreenWidget(
      {Key? key,
      required this.topWidget,
      required this.mainWidget,
      required this.index,
      this.onTapNext,
      this.customBottomButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              height: 78,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerLeft,
              child: topWidget),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                  left: 16 * MediaQuery.of(context).size.width / 320,
                  right: 16 * MediaQuery.of(context).size.width / 320,
                  top: 34),
              height: 436,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      child: Container(
                          //padding: EdgeInsets.only(bottom: 30),
                          color: Theme.of(context).colorScheme.background,
                          child: mainWidget),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 20),
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
                                side: const BorderSide(
                                    width: 1, color: Color(0xFF000000))),
                            size: const Size.square(10.0),
                            color: Colors.transparent,
                            activeColor: const Color(0xFF000000),
                            activeSize: const Size(32.0, 10.0),
                            activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side: const BorderSide(
                                    width: 1, color: Color(0xFF000000))),
                          ),
                        ),
                        customBottomButton ??
                            InkWell(
                              child: Container(
                                width: 145,
                                height: 37,
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    border: Border.all(
                                        color: const Color(0xFF000000),
                                        width: 1)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 24,
                                    ),
                                    const Text(
                                      "다음",
                                      style: TextStyle(
                                        fontFamily: "Inter",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF000000),
                                        height: 1.5,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.chevron_right,
                                      size: 24,
                                    ),
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
