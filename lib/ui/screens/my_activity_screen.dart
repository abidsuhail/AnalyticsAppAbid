import 'dart:async';

import 'package:analytics_app/styles/app_colors.dart';
import 'package:analytics_app/ui/fragments/country_events_analytics_fragment.dart';
import 'package:analytics_app/ui/fragments/event_clicks_analytics_fragment.dart';
import 'package:analytics_app/ui/fragments/screen_analytics_fragment.dart';
import 'package:analytics_app/ui/screens/calc_screen.dart';
import 'package:analytics_app/utils/app_constants.dart';
import 'package:analytics_app/utils/app_firebase_helper.dart';
import 'package:analytics_app/utils/base_screen_tracker.dart';
import 'package:analytics_app/utils/app_utils.dart';
import 'package:analytics_app/utils/ui_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../menu/drawer_menu.dart';

class MyActivityScreen extends StatefulWidget {
  MyActivityScreen({Key? key}) : super(key: key);

  @override
  State<MyActivityScreen> createState() => _MyActivityScreenState();
}

class _MyActivityScreenState extends State<MyActivityScreen>
    with WidgetsBindingObserver, BaseScreenTracker {
  int count = 0;
  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initScreenTracker(widget);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("BirdFlyingScreen : " + state.toString());
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

  void refreshHostScreenByFragmentOnRefresh() {
    removeScreenTracker(widget);
    initScreenTracker(widget, incrementTimesOpened: false);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.removeScreenTracker(widget);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("My Activity"),
          centerTitle: true,
          backgroundColor: AppColors.primaryColor,
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.mobile_screen_share),
              ),
              Tab(
                icon: Icon(Icons.ads_click),
              ),
              Tab(
                icon: Icon(Icons.location_on_rounded),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ScreenAnalyticsFragment(refreshHostScreenByFragmentOnRefresh),
            EventClicksAnalyticsFragment(refreshHostScreenByFragmentOnRefresh),
            CountryEventsAnalyticsFragment(refreshHostScreenByFragmentOnRefresh)
          ],
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
