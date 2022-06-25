import 'package:analytics_app/repository/auth_repo.dart';
import 'package:analytics_app/repository/firestore_db_repo.dart';
import 'package:analytics_app/utils/app_shared_prefs.dart';
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
      emit(GetScreenTimeLoadingState());
      if (!AppFirebaseHelper.isAuthenticated()) {
        throw Exception('User Logged Out!');
      }
      DocumentSnapshot documentSnapshot = await repo.getScreensAnalytics();
      if (documentSnapshot.exists) {
        Map<String, double> map =
            getPieMap(documentSnapshot.data()!, 'duration');

        emit(GetScreenTimeSuccessState(map));
      } else {
        emit(GetScreenTimeErrorState('Data Not Exists!'));
      }
    } catch (e) {
      print(e);
      emit(GetScreenTimeErrorState(e.toString()));
    }
  }

  void getScreensOpenedAnalytics() async {
    try {
      emit(GetScreenOpenedLoadingState());
      if (!AppFirebaseHelper.isAuthenticated()) {
        throw Exception('User Logged Out!');
      }
      DocumentSnapshot documentSnapshot = await repo.getScreensAnalytics();
      if (documentSnapshot.exists) {
        /*Map<String, double> map =
            ((documentSnapshot.data() as Map<String, dynamic>)
                .map((key, value) {
          Map<String, dynamic> finalMap = (value as Map<String, dynamic>);
          String timesOpened = finalMap['times_opened'] == null
              ? "0"
              : (finalMap['times_opened']).toString();
          return MapEntry(key, double.parse(timesOpened));
        }));*/
        //print(map);
        Map<String, double> map =
            getPieMap(documentSnapshot.data()!, 'times_opened');
        emit(GetScreenOpenedSuccessState(map));
      } else {
        emit(GetScreenOpenedErrorState('Data Not Exists!'));
      }
    } catch (e) {
      print(e);
      emit(GetScreenOpenedErrorState(e.toString()));
    }
  }

  void getEventClicksAnalytics() async {
    try {
      emit(GetEventsClickedLoadingState());
      if (!AppFirebaseHelper.isAuthenticated()) {
        throw Exception('User Logged Out!');
      }
      DocumentSnapshot documentSnapshot = await repo.getEventsClicksAnalytics();
      if (documentSnapshot.exists) {
        /*  Map<String, double> map =
            ((documentSnapshot.data() as Map<String, dynamic>)
                .map((key, value) {
          Map<String, dynamic> finalMap = (value as Map<String, dynamic>);
          return MapEntry(
              key, double.parse((finalMap['click_count']).toString()));
        }));*/
        //print(map);
        Map<String, double> map =
            getPieMap(documentSnapshot.data()!, 'click_count');
        emit(GetEventsClickedSuccessState(map));
      } else {
        emit(GetEventsClickedErrorState('Data Not Exists!'));
      }
    } catch (e) {
      print(e);
      emit(GetEventsClickedErrorState(e.toString()));
    }
  }

  Map<String, double> getPieMap(Object data, String keyName) {
    return ((data as Map<String, dynamic>).map((key, value) {
      Map<String, dynamic> finalMap = (value as Map<String, dynamic>);
      return MapEntry(
          key,
          double.parse(
              (finalMap[keyName] == null ? "0" : (finalMap[keyName]).toString())
                  .toString()));
    }));
  }
}
