import 'package:flutter/material.dart';
import 'package:meetble/view/widgets/pie_timer_widget/utils.dart';

import '../../../data/model/time_range_model.dart';
import 'degree_options.dart';
import '../time_picker_widget/time_button.dart';
import 'chart_painter.dart';
import 'chart_values_options.dart';

enum LegendPosition { top, bottom, left, right }

enum ChartType { disc, ring }

typedef OnTimeSelected = void Function(int selectedTime);

class PieTimer extends StatefulWidget {
  const PieTimer({
    required this.dataMap,
    this.chartType = ChartType.disc,
    this.chartRadius,
    this.animationDuration,
    this.chartLegendSpacing = 48,
    this.colorList = defaultColorList,
    //this.initialAngleInDegree,
    this.formatChartValues,
    this.centerText,
    this.centerTextStyle,
    this.ringStrokeWidth = 20.0,
    this.chartValuesOptions = const ChartValuesOptions(),
    this.emptyColor = Colors.grey,
    //this.gradientList,
    //this.emptyColorGradient = const [Colors.black26, Colors.black54],
    this.legendLabels = const {},
    Key? key,
    //this.degreeOptions = const DegreeOptions(),
    this.baseChartColor = Colors.transparent,
    this.totalValue,
    this.shortCutTime,
    this.onShortCutSelected,
    this.onTimeSelected,
  }) : super(key: key);

  final Map<String, double> dataMap;
  final ChartType chartType;
  final double? chartRadius;
  final Duration? animationDuration;
  final double chartLegendSpacing;
  final List<Color> colorList;
  //final List<List<Color>>? gradientList;
  @Deprecated('use degreeOptions. instead')
  //final double? initialAngleInDegree;
  final Function? formatChartValues;
  final String? centerText;
  final TextStyle? centerTextStyle;
  final double ringStrokeWidth;
  final ChartValuesOptions chartValuesOptions;
  final Color emptyColor;
  //final List<Color> emptyColorGradient;
  //final DegreeOptions degreeOptions;
  final Map<String, String> legendLabels;
  final Color baseChartColor;
  final double? totalValue;

  final List<TimeRangeModel>? shortCutTime;
  final Function? onShortCutSelected;
  final OnTimeSelected? onTimeSelected;

  @override
  // ignore: library_private_types_in_public_api
  _PieTimerState createState() => _PieTimerState();
}

class _PieTimerState extends State<PieTimer>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  AnimationController? controller;
  double _animFraction = 0.0;

  List<String>? legendTitles;
  late List<double> legendValues;

  void initLegends() {
    final List<String> legendLabelList =
        widget.dataMap.keys.toList(growable: false);
    legendTitles = legendLabelList
        .map((label) => widget.legendLabels[label] ?? label)
        .toList(growable: false);
  }

  void initValues() {
    legendValues = widget.dataMap.values.toList(growable: false);
  }

  void initData() {
    assert(
      widget.dataMap.isNotEmpty,
      "dataMap passed to pie chart cant be null or empty",
    );
    initLegends();
    initValues();
  }

  @override
  void initState() {
    super.initState();
    initData();
    /*
    controller = AnimationController(
      duration: widget.animationDuration ?? const Duration(milliseconds: 800),
      vsync: this,
    );
    final Animation curve = CurvedAnimation(
      parent: controller!,
      curve: Curves.decelerate,
    );
    animation =
        Tween<double>(begin: 0, end: 1).animate(curve as Animation<double>)
          ..addListener(() {
            setState(() {
              _animFraction = animation.value;
            });
          });
    controller!.forward();

     */
  }

  Widget _getChart() {
    return Container(
      child: LayoutBuilder(
        builder: (_, c) => SizedBox(
          height: widget.chartRadius != null
              ? c.maxWidth < widget.chartRadius!
                  ? c.maxWidth
                  : widget.chartRadius
              : null,
          child: CustomPaint(
            painter: PieChartPainter(
              _animFraction,
              widget.colorList,
              //chartValueStyle: widget.chartValuesOptions.chartValueStyle,
              //chartValueBackgroundColor: widget.chartValuesOptions.chartValueBackgroundColor,
              values: legendValues,
              titles: legendTitles,
              decimalPlaces: widget.chartValuesOptions.decimalPlaces,
              chartType: widget.chartType,
              centerText: widget.centerText,
              centerTextStyle: widget.centerTextStyle,
              //formatChartValues: widget.formatChartValues,
              strokeWidth: widget.ringStrokeWidth,
              emptyColor: widget.emptyColor,
              //gradientList: widget.gradientList,
              //emptyColorGradient: widget.emptyColorGradient,
                /*
              degreeOptions: widget.degreeOptions.copyWith(
                // because we've deprecated initialAngleInDegree,
                // we want the old value to be used if it's not null
                // ignore: deprecated_member_use_from_same_package
                initialAngle: widget.initialAngleInDegree,
              ),

                 */
              baseChartColor: widget.baseChartColor,
              totalValue:widget.totalValue
            ),
            child: const AspectRatio(aspectRatio: 1),
          ),
        ),
      ),
    );
  }

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
      children: [
        Container(
          padding: EdgeInsets.only(top: 14, bottom: 25),
          height: 61,
          color: Colors.green,
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
                        widget.onShortCutSelected!.call();
                        if(index != _selectedShortCutIndex){
                          int startTime = widget.shortCutTime![index].start;
                          for(int i = 0; i <= widget.shortCutTime![index].duration; i++)  {
                            widget.onTimeSelected!.call(startTime + i);
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
        ),
        Container(
          alignment: Alignment.center,
          child: _getChart(),
        )
      ],
    );
  }

  @override
  void didUpdateWidget(PieTimer oldWidget) {
    initData();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
