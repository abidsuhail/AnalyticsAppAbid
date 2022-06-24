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
      emit(GetScreenTimeLoadingState());
      DocumentSnapshot documentSnapshot = await repo.getScreensAnalytics();
      if (documentSnapshot.exists) {
        Map<String, double> screenDurmap =
            ((documentSnapshot.data() as Map<String, dynamic>)
                .map((key, value) {
          Map<String, dynamic> finalMap = (value as Map<String, dynamic>);
          return MapEntry(
              key, double.parse((finalMap['duration'] / 60).toString()));
        }));

        emit(GetScreenTimeSuccessState(screenDurmap));
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
      DocumentSnapshot documentSnapshot = await repo.getScreensAnalytics();
      if (documentSnapshot.exists) {
        /* emit(GetScreenAnalyticSuccessState((documentSnapshot.data()
                as Map<String, Map<String, dynamic>>)
            .entries
            .map((e) => ScreenModel2(key: e.key, value: e.value['duration']))
            .toList()));*/
        /* (documentSnapshot.data() as Map<String, dynamic>)
            .map((key, value) => MapEntry(key, value['duration'] ?? '0'));*/

        Map<String, double> map =
            ((documentSnapshot.data() as Map<String, dynamic>)
                .map((key, value) {
          Map<String, dynamic> finalMap = (value as Map<String, dynamic>);
          return MapEntry(
              key, double.parse((finalMap['times_opened']).toString()));
        }));
        //print(map);
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
      DocumentSnapshot documentSnapshot = await repo.getEventsClicksAnalytics();
      if (documentSnapshot.exists) {
        /* emit(GetScreenAnalyticSuccessState((documentSnapshot.data()
                as Map<String, Map<String, dynamic>>)
            .entries
            .map((e) => ScreenModel2(key: e.key, value: e.value['duration']))
            .toList()));*/
        /* (documentSnapshot.data() as Map<String, dynamic>)
            .map((key, value) => MapEntry(key, value['duration'] ?? '0'));*/

        Map<String, double> map =
            ((documentSnapshot.data() as Map<String, dynamic>)
                .map((key, value) {
          Map<String, dynamic> finalMap = (value as Map<String, dynamic>);
          return MapEntry(
              key, double.parse((finalMap['click_count']).toString()));
        }));
        //print(map);
        emit(GetEventsClickedSuccessState(map));
      } else {
        emit(GetEventsClickedErrorState('Data Not Exists!'));
      }
    } catch (e) {
      print(e);
      emit(GetEventsClickedErrorState(e.toString()));
    }
  }
}
