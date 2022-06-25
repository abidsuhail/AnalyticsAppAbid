import 'package:equatable/equatable.dart';

import '../../models/country_event_model.dart';

abstract class TrackerState extends Equatable {}

class TrackerInitialState extends TrackerState {
  @override
  List<Object> get props => [];
}
