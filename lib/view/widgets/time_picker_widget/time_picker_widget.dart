import 'package:flutter/material.dart';
import 'package:meetble/view/widgets/time_picker_widget/painter/arc_painter.dart';
import 'package:meetble/view/widgets/time_picker_widget/painter/background_painter.dart';
import 'package:meetble/view/widgets/time_picker_widget/painter/horizontal_border_painter.dart';
import 'package:meetble/view/widgets/time_picker_widget/time_button.dart';

import '../../../data/model/time_range_model.dart';
import 'arc_button.dart';

typedef OnTimeSelected = void Function(int selectedTime);

class TimePickerWidget extends StatefulWidget {
  final double width;
  final OnTimeSelected? onTapTime;
  final List<TimeRangeModel>? shortCutTime;
  final Function? resetSelectedTime;
  final List<int> timeRange;

  const TimePickerWidget({
    Key? key,
    required this.width,
    this.onTapTime,
    this.shortCutTime,
    this.resetSelectedTime,
    required this.timeRange,
  }) : super(key: key);

  @override
  State<TimePickerWidget> createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  int? _selectedShortCutIndex;

  void _selectShortCutTime(int index) {
    if(_selectedShortCutIndex == null || _selectedShortCutIndex != index) {
      _selectedShortCutIndex = index;
    }
    else{
      _selectedShortCutIndex = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        widget.shortCutTime!.isNotEmpty ?
        Container(
          padding: EdgeInsets.only(top: 14, bottom: 25),
          height: 61,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            primary: false,
            scrollDirection: Axis.horizontal,
            itemCount: widget.shortCutTime!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(right: 9),
                child: TimeButton(
                    onTap: (){
                      setState((){
                        widget.resetSelectedTime!.call();
                        if(index != _selectedShortCutIndex){
                          int startTime = widget.shortCutTime![index].start;
                          for(int i = 0; i < widget.shortCutTime![index].duration; i++)  {
                            widget.onTapTime!.call(startTime + i);
                          }
                        }
                        _selectShortCutTime(index);
                      });
                    },
                    isSelected: index == _selectedShortCutIndex,
                    buttonText: widget.shortCutTime![index].rangeName
                ),
              );
            },
          ),
        ) : Container(),
        Center(
          child: Text(
            '6 AM',
            style: TextStyle(
              fontFamily: "Inter",
              fontWeight: FontWeight.w500,
              color: Color(0xFF000000).withOpacity(0.5),
              fontSize: 12,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: widget.width,
          height: widget.width,
          child: Stack(
            children: [
              for(int i = 0; i < 24; i++)
              Stack(
                children: [
                  ArcButton(
                    radius: widget.width / 2,
                    isSelected: widget.timeRange.contains(i),
                    time: i,
                    startPoint: 2,
                    onTap: (){
                      setState((){
                        widget.onTapTime!.call(i);
                      });
                    },
                  ),
                  CustomPaint(
                    painter: ArcPainter(
                        radius: widget.width / 2,
                        time: i,
                        radiusRatio: 2/3,
                        isSelected: widget.timeRange.contains(i),
                        offTimeTextStyle: TextStyle(fontWeight: FontWeight.w500, color: Color(0xFF000000).withOpacity(0.3), fontSize: 8),
                        textPadding: 3
                    ),
                  )
                ],
              ),
              CustomPaint(
                painter: BackgroundPainter(radius: widget.width / 2, radiusRatio: 2/3),
                foregroundPainter: HorizontalBorderPainter(
                  textPadding: 3,
                  radius: widget.width/2,
                  isPmSelected: widget.timeRange.contains(11),
                  isAmSelected: widget.timeRange.contains(23),
                  offHorizontalBorderTimeTextStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF000000).withOpacity(0.5),
                    fontSize: 8,
                  ),
                  onHorizontalBorderTimeTextStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF000000),
                    fontSize: 8,
                  ),
                ),
              ),
              Center(
                child: CircleAvatar(
                  radius: widget.width /3,
                  backgroundColor: Color(0xFFFFFFFF),
                  backgroundImage: AssetImage(
                    "images/4.0x/time.png",
                  ),
                ),
              )
            ],
          )
        ),
        Center(
          child: Text(
            '6 PM',
            style: TextStyle(
              fontFamily: "Inter",
              fontWeight: FontWeight.w500,
              color: Color(0xFF000000).withOpacity(0.5),
              fontSize: 12,
            ),
          ),
        ),
      ]
    );
  }
}


