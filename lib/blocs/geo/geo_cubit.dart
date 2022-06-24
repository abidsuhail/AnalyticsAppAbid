import 'package:analytics_app/models/country_event_model.dart';
import 'package:analytics_app/repository/auth_repo.dart';
import 'package:analytics_app/repository/firestore_db_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

import '../../utils/app_firebase_helper.dart';
import 'geo_state.dart';

class GeoCubit extends Cubit<GeoState> {
  final FirestoreDbRepo repo = FirestoreDbRepo.getInstance();
  GeoCubit() : super(GeoInitialState());

  void getMyLocationEvents(BuildContext context) async {
    try {
      emit(GetMyLocationEventLoadingState());
      QuerySnapshot? querySnapshot = await repo.getMyLocationEvents(context);
      if (querySnapshot != null) {
        List<CountryEventModel> countryEventsList = querySnapshot.docs
            .map((e) =>
                CountryEventModel.fromJson(e.data() as Map<String, dynamic>))
            .toList();
        emit(GetMyLocationEventSuccessState(countryEventsList));
      } else {
        emit(GetMyLocationEventErrorState('Something went wrong'));
      }
    } catch (e) {
      print(e);
      emit(GetMyLocationEventErrorState(e.toString()));
    }
  }
}
