import 'dart:async';

import 'package:analytics_app/styles/app_colors.dart';
import 'package:analytics_app/utils/app_constants.dart';
import 'package:analytics_app/utils/app_firebase_helper.dart';
import 'package:analytics_app/ui/screens/base/base_screen_tracker.dart';
import 'package:analytics_app/utils/app_utils.dart';
import 'package:analytics_app/utils/ui_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../menu/drawer_menu.dart';

class Screen1Screen extends StatefulWidget {
  Screen1Screen({Key? key}) : super(key: key);

  @override
  State<Screen1Screen> createState() => _Screen1ScreenState();
}

class _Screen1ScreenState extends State<Screen1Screen>
    with WidgetsBindingObserver, BaseScreenTracker {
  int count = 0;
  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initScreenTracker(widget, context);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("BirdFlyingScreen : " + state.toString());
    if (state == AppLifecycleState.resumed) {
      super.initScreenTracker(widget, context);
      return;
    } /* else if (state == AppLifecycleState.inactive) {
      super.removeScreenTracker(widget);
      return;
    } */
    else if (state == AppLifecycleState.paused) {
      super.removeScreenTracker(widget, context);
      return;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.removeScreenTracker(widget, context);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("Screen 1"),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      body: Container(child: Center(child: Text('Screen 1'))),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
