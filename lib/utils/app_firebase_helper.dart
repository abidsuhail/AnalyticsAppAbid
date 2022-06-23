import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
}
