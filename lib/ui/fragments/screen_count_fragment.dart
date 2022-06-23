import 'dart:async';
import 'dart:convert';

import 'package:analytics_app/blocs/tracker/my_activity_cubit.dart';
import 'package:analytics_app/blocs/tracker/my_activity_state.dart';
import 'package:analytics_app/styles/app_colors.dart';
import 'package:analytics_app/ui/screens/calc_screen.dart';
import 'package:analytics_app/utils/app_constants.dart';
import 'package:analytics_app/utils/app_firebase_helper.dart';
import 'package:analytics_app/utils/base_screen_tracker.dart';
import 'package:analytics_app/utils/app_utils.dart';
import 'package:analytics_app/utils/ui_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../menu/drawer_menu.dart';

class ScreenCountFragment extends StatefulWidget {
  ScreenCountFragment({Key? key}) : super(key: key);

  @override
  State<ScreenCountFragment> createState() => _ScreenCountFragmentState();
}

class _ScreenCountFragmentState extends State<ScreenCountFragment>
    with WidgetsBindingObserver, BaseScreenTracker {
  int count = 0;
  late MyActivityCubit myActivityCubit;
  @override
  void initState() {
    myActivityCubit = BlocProvider.of<MyActivityCubit>(context);
    myActivityCubit.getScreensAnalytics();
    WidgetsBinding.instance?.addObserver(this);
    super.initScreenTracker(widget);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("SCREENCOUNT : " + state.toString());
    if (state == AppLifecycleState.resumed) {
      super.initScreenTracker(widget);
      return;
    } /* else if (state == AppLifecycleState.inactive) {
      super.removeScreenTracker(widget);
      return;
    } */
    else if (state == AppLifecycleState.paused) {
      super.removeScreenTracker(widget);
      return;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.removeScreenTracker(widget);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: BlocConsumer<MyActivityCubit, MyActivityState>(
        listener: (context, state) {
          if (state is GetScreenAnalyticErrorState) {
            UIHelper.showAlertDialog(context, state.msg);
          }
        },
        builder: (context, state) {
          if (state is GetScreenAnalyticLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetScreenAnalyticSuccessState) {
            return Center(
                child: PieChart(
              dataMap: state.mapScreenDuration,
              animationDuration: const Duration(milliseconds: 800),
              chartLegendSpacing: 32,
              chartRadius: MediaQuery.of(context).size.width / 2,
              colorList: AppColors.chartColorList,
              initialAngleInDegree: 0,
              chartType: ChartType.ring,
              ringStrokeWidth: 32,
              centerText: "SCREEN\nTIME",
              legendOptions: const LegendOptions(
                showLegendsInRow: false,
                legendPosition: LegendPosition.right,
                showLegends: true,
                legendShape: BoxShape.circle,
                legendTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              chartValuesOptions: const ChartValuesOptions(
                showChartValueBackground: false,
                showChartValues: true,
                showChartValuesInPercentage: false,
                showChartValuesOutside: false,
                decimalPlaces: 1,
              ),
              // gradientList: ---To add gradient colors---
              // emptyColorGradient: ---Empty Color gradient---
            ));
          }
          return const Center(child: Text('No Data!'));
        },
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void onTapEvent1() {}
  void onTapEvent2() {}
  void onTapEvent3() {}
  void onTapEvent4() {}
}
