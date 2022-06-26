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
    initScreenTracker(widget, context);
    super.initState();
  }

  void fetchData({required bool isInitState}) {
    if (!isInitState) {
      removeScreenTracker(widget, context);
      initScreenTracker(widget, context);
    }
    widget.refreshHostScreenTrackingDetails();
    myActivityCubit.getEventClicksAnalytics();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("EVENTS clicked : " + state.toString());
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
            const SizedBox(
              height: 30,
            ),
            Column(
              children: [
                const Text(
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
            const SizedBox(
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
                  return AppPieChartWidget(
                      mapData: state.mapScreenEvents,
                      chartRadius: MediaQuery.of(context).size.width / 1.5,
                      isDecimal: false,
                      centerTxt: "EVENTS\nCLICKED COUNT");
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
