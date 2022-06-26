import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/screen_tracker_info.dart';
import '../utils/app_firebase_helper.dart';
import '../utils/app_geo_helper.dart';

class TrackerRepo {
  static TrackerRepo? _mInstance;
  static final Map<String, ScreenTrackerTimestamp> _mapTimestamp =
      <String, ScreenTrackerTimestamp>{};
  static TrackerRepo getInstance() {
    _mInstance ??= TrackerRepo();
    return _mInstance!;
  }

  Future<void> onClickTrack(String clickName, BuildContext context) async {
    DocumentReference doc = AppFirebaseHelper.getMyClicksDocRef();
    await doc.set({
      clickName: {
        "click_count": FieldValue.increment(1),
        "event_name": clickName,
        "country": await AppGeoHelper.getMyCountry(context)
      },
    }, SetOptions(merge: true));
    CollectionReference? myLocRefEvent =
        await AppFirebaseHelper.getMyLocationEventsColRef(context);
    await myLocRefEvent.add({
      "event_name": clickName,
      "country": (await AppGeoHelper.getMyCountry(context)) ?? ""
    });
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

  void durationScreenOpened(Widget widget, double duration) {
    DocumentReference doc = AppFirebaseHelper.getMyScreenDocRef();
    doc.set({
      widget.runtimeType.toString(): {
        "duration_mins": FieldValue.increment(duration),
        "screen_name": widget.runtimeType.toString()
      },
    }, SetOptions(merge: true));
    print(duration.toString());
  }

  void removeScreenTracker(Widget widget) {
    /**
        start date at init screen
        end date at dispose screen
        find the diff b/w them and send to firestore
     */
    _mapTimestamp[widget.runtimeType.toString()]?.endTime = DateTime.now();
    DateTime? startTime =
        _mapTimestamp[widget.runtimeType.toString()]?.startTime;
    DateTime? endTime = _mapTimestamp[widget.runtimeType.toString()]?.endTime;
    if (startTime == null || endTime == null) {
      print(
          'either value is null, startTime = ${startTime} endTime = ${endTime}');
      return;
    }

    ///converting seconds to minutes
    ///update data to db
    int seconds = (endTime.difference(startTime).inSeconds);
    //int minutes = ((seconds > 0) ? (seconds / 60) : 0).round();
    double minutes =
        double.parse(((seconds > 0) ? (seconds / 60) : 0).toStringAsFixed(1));

    print("------------------------------->minutes : ${minutes}");
    durationScreenOpened(widget, minutes);
  }

  void initScreenTracker(Widget widget, {bool? incrementTimesOpened}) {
    /**
        start date at init screen
        end date at dispose screen
        find the diff b/w them and send to firestore
     */
    if (incrementTimesOpened == null || incrementTimesOpened) {
      ///+1 count screen opens on init screen
      incTimeScreenOpened(widget);
    }

    /**
     *  "widget.runtimeType.toString()" is dynamic screen name,
     *  Saving timestamp when specific screen opens
     * */
    _mapTimestamp[widget.runtimeType.toString()] =
        ScreenTrackerTimestamp(startTime: DateTime.now());
  }
}
