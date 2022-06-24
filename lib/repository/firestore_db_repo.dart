import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/app_firebase_helper.dart';

class FirestoreDbRepo {
  static FirestoreDbRepo? _mInstance;

  static FirestoreDbRepo getInstance() {
    _mInstance ??= FirestoreDbRepo();
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
    /*  print("------------------->" +
        (await AppFirebaseHelper.getMyLocationEventsColRef(context))?.path);*/

    return (await AppFirebaseHelper.getMyLocationEventsColRef(context)).get();
  }
  /* Future<DocumentSnapshot> getClicksAnalytics() async {
    return await AppFirebaseHelper.getMyClicksDocRef().get();
  }*/
}
