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
import 'package:analytics_app/widgets/app_rounded_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../menu/drawer_menu.dart';

class EventClicksAnalyticsFragment extends StatefulWidget {
  final Function() refreshHostScreenTrackingDetails;

  const EventClicksAnalyticsFragment(this.refreshHostScreenTrackingDetails,
      {Key? key})
      : super(key: key);

  @override
  State<EventClicksAnalyticsFragment> createState() =>
      _EventClicksAnalyticsFragmentState();
}

class _EventClicksAnalyticsFragmentState
    extends State<EventClicksAnalyticsFragment>
    with WidgetsBindingObserver, BaseScreenTracker {
  int count = 0;
  late MyActivityCubit myActivityCubit;
  @override
  void initState() {
    myActivityCubit = BlocProvider.of<MyActivityCubit>(context);
    fetchData(isInitState: true);
    //myActivityCubit.getScreensOpenedAnalytics();

    WidgetsBinding.instance?.addObserver(this);
    initScreenTracker(widget);
    super.initState();
  }

  void fetchData({required bool isInitState}) {
    if (!isInitState) {
      removeScreenTracker(widget);
      initScreenTracker(widget);
    }
    widget.refreshHostScreenTrackingDetails();
    myActivityCubit.getEventClicksAnalytics();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("EVENTS clicked : " + state.toString());
    if (state == AppLifecycleState.resumed) {
      initScreenTracker(widget);
      return;
    } /* else if (state == AppLifecycleState.inactive) {
      super.removeScreenTracker(widget);
      return;
    } */

    else if (state == AppLifecycleState.paused) {
      removeScreenTracker(widget);
      return;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    removeScreenTracker(widget);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 15, bottom: 40),
        child: Column(
          children: [
            AppRoundedButton(
                label: 'REFRESH',
                onPressed: () {
                  onClickTrack('RefreshEventsClicksButton', context);

                  fetchData(isInitState: false);
                }),
            SizedBox(
              height: 30,
            ),
            Column(
              children: [
                Text(
                  'EVENTS CLICKED',
                  style: TextStyle(fontSize: 24, letterSpacing: 1.5),
                ),
                Container(
                  width: 150,
                  color: AppColors.primaryColor,
                  height: 3,
                )
              ],
            ),
            SizedBox(
              height: 40,
            ),
            BlocConsumer<MyActivityCubit, MyActivityState>(
              listener: (context, state) {
                if (state is GetEventsClickedErrorState) {
                  UIHelper.showAlertDialog(context, state.msg);
                }
              },
              buildWhen: (context, state) {
                return (state is GetEventsClickedSuccessState) ||
                    (state is GetEventsClickedLoadingState) ||
                    (state is GetEventsClickedErrorState);
              },
              builder: (context, state) {
                if (state is GetEventsClickedLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is GetEventsClickedSuccessState) {
                  return Center(
                      child: PieChart(
                    dataMap: state.mapScreenEvents,
                    animationDuration: const Duration(milliseconds: 800),
                    chartLegendSpacing: 32,
                    chartRadius: MediaQuery.of(context).size.width / 1.5,
                    colorList: AppColors.chartColorList,
                    initialAngleInDegree: 0,
                    chartType: ChartType.ring,
                    ringStrokeWidth: 32,
                    centerText: "EVENTS\nCLICKED",
                    legendOptions: const LegendOptions(
                      showLegendsInRow: false,
                      legendPosition: LegendPosition.bottom,
                      showLegends: true,
                      legendShape: BoxShape.circle,
                      legendTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    chartValuesOptions: const ChartValuesOptions(
                      showChartValueBackground: false,
                      showChartValues: true,
                      /*     chartValueStyle:
                          TextStyle(fontSize: 5, color: Colors.black),*/
                      showChartValuesInPercentage: false,
                      showChartValuesOutside: false,
                      decimalPlaces: 0,
                    ),
                  ));
                }
                return const Center(child: Text('No Data!'));
              },
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
