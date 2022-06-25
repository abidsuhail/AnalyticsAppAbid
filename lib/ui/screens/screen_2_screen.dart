import 'dart:async';

import 'package:analytics_app/styles/app_colors.dart';
import 'package:analytics_app/utils/app_constants.dart';
import 'package:analytics_app/utils/app_firebase_helper.dart';
import 'package:analytics_app/utils/base_screen_tracker.dart';
import 'package:analytics_app/utils/app_utils.dart';
import 'package:analytics_app/utils/ui_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../menu/drawer_menu.dart';

class Screen2Screen extends StatefulWidget {
  Screen2Screen({Key? key}) : super(key: key);

  @override
  State<Screen2Screen> createState() => _Screen2ScreenState();
}

class _Screen2ScreenState extends State<Screen2Screen>
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

      appBar: AppBar(
        title: const Text("Screen 2"),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      body: Container(child: const Center(child: const Text('Screen 2'))),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void onTapEvent1() {}
  void onTapEvent2() {}
  void onTapEvent3() {}
  void onTapEvent4() {}
}
