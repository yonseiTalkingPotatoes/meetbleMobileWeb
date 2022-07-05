import 'package:flutter/material.dart';

import '../../widgets/frame_screen_widget.dart';

class CreateScreen01 extends StatelessWidget {
  const CreateScreen01({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("CreateScreen01");
    return FrameScreenWidget(
      topWidget: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '가능한 날짜를 모두 선택해주세요!',
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
      mainWidget: Container(
        height: 200,
        color: Colors.blue,
      ),
      index: 1,
      onTapNext: () {},
    );
  }
}
