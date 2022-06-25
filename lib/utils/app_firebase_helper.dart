import 'package:analytics_app/utils/app_geo_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AppFirebaseHelper {
  static FirebaseAuth getAuthInstance() {
    return FirebaseAuth.instance;
  }

  static bool isAuthenticated() {
    return FirebaseAuth.instance.currentUser != null;
  }

  static String? getUid() {
    return FirebaseAuth.instance.currentUser?.uid;
  }

  static Future logout() async {
    return await FirebaseAuth.instance.signOut();
  }

  static DocumentReference getMyScreenDocRef() {
    return FirebaseFirestore.instance
        .collection('screens')
        .doc(AppFirebaseHelper.getUid());
  }

  static DocumentReference getMyClicksDocRef() {
    return FirebaseFirestore.instance
        .collection('clicks')
        .doc(AppFirebaseHelper.getUid());
  }

  static Future<CollectionReference> getMyLocationEventsColRef(
      BuildContext context) async {
    return FirebaseFirestore.instance
        .collection('location_events')
        .doc(AppFirebaseHelper.getUid())
        .collection("country_events");
  }

  static CollectionReference getAllUserColRef() {
    return FirebaseFirestore.instance.collection('users');
  }
}
