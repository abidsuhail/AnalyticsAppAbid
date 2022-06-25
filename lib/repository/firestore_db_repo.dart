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
