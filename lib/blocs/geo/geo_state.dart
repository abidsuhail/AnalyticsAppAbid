import 'package:equatable/equatable.dart';

import '../../models/country_event_model.dart';

abstract class GeoState extends Equatable {}

class GeoInitialState extends GeoState {
  @override
  List<Object> get props => [];
}

class GetMyLocationEventLoadingState extends GeoState {
  @override
  List<Object> get props => [];
}

class GetMyLocationEventSuccessState extends GeoState {
  final List<CountryEventModel> countryEventsList;

  GetMyLocationEventSuccessState(this.countryEventsList);
  @override
  List<Object> get props => [countryEventsList];
}

class GetMyLocationEventErrorState extends GeoState {
  final String msg;

  GetMyLocationEventErrorState(this.msg);

  @override
  List<Object> get props => [];
}

///------------------------------------------------------------------------------------------
