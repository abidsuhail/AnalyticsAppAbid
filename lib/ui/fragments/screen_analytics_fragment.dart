import 'dart:async';
import 'dart:convert';

import 'package:analytics_app/styles/app_colors.dart';
import 'package:analytics_app/utils/app_constants.dart';
import 'package:analytics_app/utils/app_firebase_helper.dart';
import 'package:analytics_app/ui/screens/base/base_screen_tracker.dart';
import 'package:analytics_app/utils/app_utils.dart';
import 'package:analytics_app/utils/ui_helper.dart';
import 'package:analytics_app/widgets/app_pie_chart_widget.dart';
import 'package:analytics_app/widgets/app_rounded_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../blocs/myactivity/my_activity_cubit.dart';
import '../../blocs/myactivity/my_activity_state.dart';
import '../../menu/drawer_menu.dart';

class ScreenAnalyticsFragment extends StatefulWidget {
  final Function() refreshHostScreenTrackingDetails;
  ScreenAnalyticsFragment(this.refreshHostScreenTrackingDetails, {Key? key})
      : super(key: key);

  @override
  State<ScreenAnalyticsFragment> createState() =>
      _ScreenAnalyticsFragmentState();
}

class _ScreenAnalyticsFragmentState extends State<ScreenAnalyticsFragment>
    with WidgetsBindingObserver, BaseScreenTracker {
  int count = 0;
  late MyActivityCubit myActivityCubit;
  @override
  void initState() {
    myActivityCubit = BlocProvider.of<MyActivityCubit>(context);
    fetchData(isInitState: true);
    //myActivityCubit.getScreensOpenedAnalytics();

    WidgetsBinding.instance?.addObserver(this);
    initScreenTracker(widget, context);
    super.initState();
  }

  void fetchData({required bool isInitState}) {
    if (!isInitState) {
      removeScreenTracker(widget, context);
      initScreenTracker(widget, context);
    }
    widget.refreshHostScreenTrackingDetails();
    myActivityCubit.getScreensAnalytics();
    myActivityCubit.getScreensOpenedAnalytics();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("SCREEN ANALYTIC CLICKED : " + state.toString());
    if (state == AppLifecycleState.resumed) {
      initScreenTracker(widget, context);
      return;
    } /* else if (state == AppLifecycleState.inactive) {
      super.removeScreenTracker(widget);
      return;
    } */

    else if (state == AppLifecycleState.paused) {
      removeScreenTracker(widget, context);
      return;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    removeScreenTracker(widget, context);
    print('dispose screen analytic');
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
                  onClickTrack('RefreshScreenAnalyticsButton', context);
                  fetchData(isInitState: false);
                }),
            SizedBox(
              height: 30,
            ),
            Column(
              children: [
                Text(
                  'SCREEN TIME',
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
                if (state is GetScreenTimeErrorState) {
                  UIHelper.showAlertDialog(context, state.msg);
                }
              },
              buildWhen: (context, state) {
                return (state is GetScreenTimeSuccessState) ||
                    (state is GetScreenTimeLoadingState) ||
                    (state is GetScreenTimeErrorState);
              },
              builder: (context, state) {
                if (state is GetScreenTimeLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is GetScreenTimeSuccessState) {
                  return AppPieChartWidget(
                      mapData: state.mapScreenDuration,
                      chartRadius: MediaQuery.of(context).size.width / 2,
                      isDecimal: true,
                      centerTxt: "SCREEN\nTIME\n(in mins)");
                }
                return const Center(child: Text('No Data!'));
              },
            ),
            const SizedBox(
              height: 30,
            ),
            const Divider(),
            const SizedBox(
              height: 30,
            ),
            Column(
              children: [
                Text(
                  'TIMES SCREEN OPENED',
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
                if (state is GetScreenOpenedErrorState) {
                  UIHelper.showAlertDialog(context, state.msg);
                }
              },
              buildWhen: (context, state) {
                return (state is GetScreenOpenedSuccessState) ||
                    (state is GetScreenOpenedLoadingState) ||
                    (state is GetScreenOpenedErrorState);
              },
              builder: (context, state) {
                if (state is GetScreenOpenedLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is GetScreenOpenedSuccessState) {
                  return AppPieChartWidget(
                      mapData: state.mapScreenOpened,
                      chartRadius: MediaQuery.of(context).size.width / 2,
                      isDecimal: false,
                      centerTxt: "TIME\'S\nOPENED");
                }
                return const Center(child: Text('No Data!'));
              },
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
