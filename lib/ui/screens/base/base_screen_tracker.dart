import 'package:analytics_app/blocs/tracker/tracker_cubit.dart';
import 'package:analytics_app/models/screen_tracker_info.dart';
import 'package:analytics_app/utils/app_geo_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/app_firebase_helper.dart';

class BaseScreenTracker {
  TrackerCubit getTrackerCubit(BuildContext context) {
    return TrackerCubit.getInstance();
  }

  void gotoScreen(BuildContext context, Widget toScreen,
      {bool? removePreviousStack,
      required Widget currentScreenTrackerWidget}) async {
    /**
     * This is special method,for navigating to another
    screen(which automatically updates screen tracking details to db)
     */
    removeScreenTracker(currentScreenTrackerWidget, context);
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => toScreen));
    initScreenTracker(currentScreenTrackerWidget, context);
  }

  void initScreenTracker(Widget widget, BuildContext context,
      {bool? incrementTimesOpened}) {
    /**
     start date at init screen
    end date at dispose screen
    find the diff b/w them and send to firestore
     */
    getTrackerCubit(context)
        .initScreenTracker(widget, incrementTimesOpened: incrementTimesOpened);
  }

  void onClickTrack(String clickName, BuildContext context) async {
    getTrackerCubit(context).onClickTrack(clickName, context);
  }

  void incTimeScreenOpened(Widget widget, BuildContext context) {
    getTrackerCubit(context).incTimeScreenOpened(widget);
  }

  void durationScreenOpened(
      Widget widget, double duration, BuildContext context) {
    getTrackerCubit(context).durationScreenOpened(widget, duration);
  }

  void removeScreenTracker(Widget widget, BuildContext context) {
    /**
     start date at init screen
    end date at dispose screen
    find the diff b/w them and send to firestore
     */
    getTrackerCubit(context).removeScreenTracker(widget);
  }
}
