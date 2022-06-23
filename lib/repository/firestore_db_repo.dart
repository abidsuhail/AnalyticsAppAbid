import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utils/app_firebase_helper.dart';

class FirestoreDbRepo {
  static FirestoreDbRepo? _mInstance;

  static FirestoreDbRepo getInstance() {
    _mInstance ??= FirestoreDbRepo();
    return _mInstance!;
  }

  Future<DocumentSnapshot> getScreensAnalytics() async {
    return await AppFirebaseHelper.getMyScreenDocRef().get();
  }

  Future<DocumentSnapshot> getClicksAnalytics() async {
    return await AppFirebaseHelper.getMyClicksDocRef().get();
  }
}
