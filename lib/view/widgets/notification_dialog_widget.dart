import 'package:flutter/material.dart';

class NotificationDialogWidget extends StatelessWidget {
  final String inputErrorMessage;
  const NotificationDialogWidget({Key? key, required this.inputErrorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            inputErrorMessage,
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
}
