import 'dart:async';

import 'package:analytics_app/models/screen_tracker_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'app_constants.dart';
import 'app_firebase_helper.dart';

class BaseScreenTracker {
  //static Map<String, Timer>? _map;
  static final Map<String, ScreenTrackerTimestamp> _mapTimestamp =
      <String, ScreenTrackerTimestamp>{};
  static final Map<String, int> _mapScreenCount = <String, int>{};
/*
  ///also one way is find the difference of start screen and end screen
  static Map<String, Timer> getTimerMap() {
    ///creating singleton map
    _map ??= <String, Timer>{};
    return _map!;
  }*/

  void gotoScreen(BuildContext context, Widget toScreen,
      {bool? removePreviousStack,
      required Widget currentScreenTrackerWidget}) async {
    removeScreenTracker(currentScreenTrackerWidget);
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => toScreen));
    initScreenTracker(currentScreenTrackerWidget);
  }

  void initScreenTracker(Widget widget) {
    ///start date at init screen
    ///end date at dispose screen
    ///find the diff b/w them and send to firestore
    ///+1 count screen opens
    incTimeScreenOpened(widget);
    _mapScreenCount[widget.runtimeType.toString()] =
        (_mapScreenCount[widget.runtimeType.toString()] ?? 0) + 1;

    print("count " + _mapScreenCount[widget.runtimeType.toString()].toString());
    _mapTimestamp[widget.runtimeType.toString()] =
        ScreenTrackerTimestamp(startTime: DateTime.now());
  }

  void onClickTrack(String clickName) {
    DocumentReference doc = AppFirebaseHelper.getMyClicksDocRef();
    doc.set({
      clickName: {
        "click_count": FieldValue.increment(1),
        "event_name": clickName
      },
    }, SetOptions(merge: true));
  }

  void incTimeScreenOpened(Widget widget) {
    DocumentReference doc = AppFirebaseHelper.getMyScreenDocRef();

    doc.set({
      widget.runtimeType.toString(): {
        "times_opened": FieldValue.increment(1),
        "screen_name": widget.runtimeType.toString()
      },
    }, SetOptions(merge: true));
  }

  void durationScreenOpened(Widget widget, int duration) {
    DocumentReference doc = FirebaseFirestore.instance
        .collection('screens')
        .doc(AppFirebaseHelper.getUid());

    doc.set({
      widget.runtimeType.toString(): {
        "duration": FieldValue.increment(duration),
        "screen_name": widget.runtimeType.toString()
      },
    }, SetOptions(merge: true));
  }
  /*void onDisposeScreenTracker(WidgetsBindingObserver widgetsBindingObserver) {
    WidgetsBinding.instance?.removeObserver(widgetsBindingObserver);
  }*/

  void removeScreenTracker(Widget widget) {
    ///start date at init screen
    ///end date at dispose screen
    ///find the diff b/w them and send to firestore
    _mapTimestamp[widget.runtimeType.toString()]?.endTime = DateTime.now();
    DateTime? startTime =
        _mapTimestamp[widget.runtimeType.toString()]?.startTime;
    DateTime? endTime = _mapTimestamp[widget.runtimeType.toString()]?.endTime;
    if (startTime == null || endTime == null) {
      print('either value is null');
      return;
    }

    durationScreenOpened(widget, endTime.difference(startTime).inSeconds);

    ///update data to db
    print(
        '${widget.runtimeType.toString()} ${endTime.difference(startTime).inSeconds.toString()}');
  }

/*  static Timer? addScreen(Widget screen) {
    print('adding ' + screen.toString());
    Map<String, Timer> map = getTimerMap();
    if (map.containsKey(screen.runtimeType.toString())) {
      removeScreen(screen);
    }
    map[screen.runtimeType.toString()] = getAndStartPeriodicTimer();
    return map[screen.runtimeType.toString()];
  }

  static void removeScreen(Widget screen) {
    print('removing ' + screen.toString());
    Map<String, Timer> map = getTimerMap();
    map[screen.runtimeType.toString()]?.cancel();
    map.remove(screen.runtimeType.toString());
  }

  static Timer getAndStartPeriodicTimer() {
    return Timer.periodic(
        const Duration(seconds: AppConstants.SCREEN_TIMER_DURATION_SEC),
        (timer) {
      print(timer.tick.toString());
    });
  }*/
}
