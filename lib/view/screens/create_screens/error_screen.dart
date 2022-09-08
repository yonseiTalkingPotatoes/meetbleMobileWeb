import 'package:flutter/material.dart';
import 'package:meetble/view/widgets/frame_screen_widget.dart';
import 'package:provider/provider.dart';

import '../../../view_model/create_screens_view_model.dart';
import '../../widgets/notification_dialog_widget.dart';
import '../../widgets/table_calander_widget/customization/calendar_style.dart';
import '../../widgets/table_calander_widget/customization/days_of_week_style.dart';
import '../../widgets/table_calander_widget/customization/header_style.dart';
import '../../widgets/table_calander_widget/shared/utils.dart';
import '../../widgets/table_calander_widget/table_calendar.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("ResultScreen");
    return Scaffold(
      body: Center(
        child: Text(
            "올바르지 않은 접근입니다"
        ),
      ),
    );
  }
}
