import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import '../styles/app_colors.dart';

class AppPieChartWidget extends StatelessWidget {
  final Map<String, double> mapData;
  final double chartRadius;
  final bool isDecimal;
  final String centerTxt;

  const AppPieChartWidget(
      {required this.mapData,
      required this.chartRadius,
      required this.isDecimal,
      required this.centerTxt,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: PieChart(
      dataMap: mapData,
      animationDuration: const Duration(milliseconds: 800),
      chartLegendSpacing: 32,
      chartRadius: chartRadius,
      colorList: AppColors.chartColorList,
      initialAngleInDegree: 0,
      chartType: ChartType.ring,
      ringStrokeWidth: 32,
      centerText: centerTxt,
      legendOptions: const LegendOptions(
        showLegendsInRow: false,
        legendPosition: LegendPosition.bottom,
        showLegends: true,
        legendShape: BoxShape.circle,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: false,
        showChartValues: true,
        showChartValuesInPercentage: false,
        showChartValuesOutside: false,
        decimalPlaces: isDecimal ? 1 : 0,
      ),
      // gradientList: ---To add gradient colors---
      // emptyColorGradient: ---Empty Color gradient---
    ));
  }
}
