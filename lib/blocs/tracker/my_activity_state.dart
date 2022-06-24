import 'package:equatable/equatable.dart';

abstract class MyActivityState extends Equatable {}

class MyActivityInitialState extends MyActivityState {
  @override
  List<Object> get props => [];
}

class GetScreenTimeLoadingState extends MyActivityState {
  @override
  List<Object> get props => [];
}

class GetScreenTimeSuccessState extends MyActivityState {
  final Map<String, double> mapScreenDuration;

  GetScreenTimeSuccessState(this.mapScreenDuration);
  @override
  List<Object> get props => [];
}

class GetScreenTimeErrorState extends MyActivityState {
  final String msg;

  GetScreenTimeErrorState(this.msg);

  @override
  List<Object> get props => [];
}

///------------------------------------------------------------------------------------------
class GetScreenOpenedLoadingState extends MyActivityState {
  @override
  List<Object> get props => [];
}

class GetScreenOpenedSuccessState extends MyActivityState {
  final Map<String, double> mapScreenOpened;

  GetScreenOpenedSuccessState(this.mapScreenOpened);
  @override
  List<Object> get props => [];
}

class GetScreenOpenedErrorState extends MyActivityState {
  final String msg;

  GetScreenOpenedErrorState(this.msg);

  @override
  List<Object> get props => [];
}

///------------------------------------------------------------------------------------------
class GetEventsClickedLoadingState extends MyActivityState {
  @override
  List<Object> get props => [];
}

class GetEventsClickedSuccessState extends MyActivityState {
  final Map<String, double> mapScreenEvents;

  GetEventsClickedSuccessState(this.mapScreenEvents);
  @override
  List<Object> get props => [];
}

class GetEventsClickedErrorState extends MyActivityState {
  final String msg;

  GetEventsClickedErrorState(this.msg);

  @override
  List<Object> get props => [];
}
