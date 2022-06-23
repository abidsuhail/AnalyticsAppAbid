import 'package:analytics_app/models/screen_model.dart';
import 'package:analytics_app/models/screen_model2.dart';
import 'package:analytics_app/repository/auth_repo.dart';
import 'package:analytics_app/repository/firestore_db_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../utils/app_firebase_helper.dart';
import 'my_activity_state.dart';

class MyActivityCubit extends Cubit<MyActivityState> {
  final FirestoreDbRepo repo = FirestoreDbRepo.getInstance();
  MyActivityCubit() : super(MyActivityInitialState());

  void getScreensAnalytics() async {
    try {
      emit(GetScreenAnalyticLoadingState());
      DocumentSnapshot documentSnapshot = await repo.getScreensAnalytics();
      if (documentSnapshot.exists) {
        /* emit(GetScreenAnalyticSuccessState((documentSnapshot.data()
                as Map<String, Map<String, dynamic>>)
            .entries
            .map((e) => ScreenModel2(key: e.key, value: e.value['duration']))
            .toList()));*/
        /* (documentSnapshot.data() as Map<String, dynamic>)
            .map((key, value) => MapEntry(key, value['duration'] ?? '0'));*/
        emit(GetScreenAnalyticSuccessState(
            (documentSnapshot.data() as Map<String, dynamic>).map(
                (key, value) => MapEntry(
                    key, int.parse(value['duration'] ?? '0').toDouble()))));
      } else {
        emit(GetScreenAnalyticErrorState('Data Not Exists!'));
      }
    } catch (e) {
      print(e);
      emit(GetScreenAnalyticErrorState(e.toString()));
    }
  }
}
