import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/screen_tracker_info.dart';
import '../utils/app_firebase_helper.dart';
import '../utils/app_geo_helper.dart';

class MyActivityRepo {
  static MyActivityRepo? _mInstance;
  static final Map<String, ScreenTrackerTimestamp> _mapTimestamp =
      <String, ScreenTrackerTimestamp>{};
  static MyActivityRepo getInstance() {
    _mInstance ??= MyActivityRepo();
    return _mInstance!;
  }

  Future<DocumentSnapshot> getScreensAnalytics() async {
    print("------------------->" + AppFirebaseHelper.getMyScreenDocRef().path);
    return await AppFirebaseHelper.getMyScreenDocRef().get();
  }

  Future<DocumentSnapshot> getEventsClicksAnalytics() async {
    print("------------------->" + AppFirebaseHelper.getMyClicksDocRef().path);

    return await AppFirebaseHelper.getMyClicksDocRef().get();
  }

  Future<QuerySnapshot?> getMyLocationEvents(BuildContext context) async {
    return (await AppFirebaseHelper.getMyLocationEventsColRef(context)).get();
  }

  void saveUserToDb(UserCredential userCredential) async {
    AppFirebaseHelper.getAllUserColRef().doc(userCredential.user?.uid).set(
        {"uid": userCredential.user?.uid, "email": userCredential.user?.email},
        SetOptions(merge: true));
  }
  /* Future<DocumentSnapshot> getClicksAnalytics() async {
    return await AppFirebaseHelper.getMyClicksDocRef().get();
  }*/
}
