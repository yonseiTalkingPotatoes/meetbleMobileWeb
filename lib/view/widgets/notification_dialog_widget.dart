import 'package:flutter/material.dart';

class NotificationDialogWidget extends StatelessWidget {
  final String title;
  final String inputErrorMessage;
  const NotificationDialogWidget(
      {Key? key, required this.inputErrorMessage, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontFamily: "Inter",
            color: Color(0xFF000000),
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      children: <Widget>[
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            Navigator.pop(context);
          },
          child: Center(
            child: IntrinsicWidth(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border:
                        Border.all(color: const Color(0xFF000000), width: 1)),
                width: 170,
                height: 30,
                alignment: Alignment.center,
                child: const Text(
                  "확인",
                  style: TextStyle(
                      fontFamily: "Inter",
                      color: Color(0xFF000000),
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
