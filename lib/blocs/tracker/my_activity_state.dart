import 'package:analytics_app/models/screen_model.dart';
import 'package:equatable/equatable.dart';

import '../../models/screen_model2.dart';

abstract class MyActivityState extends Equatable {}

class MyActivityInitialState extends MyActivityState {
  @override
  List<Object> get props => [];
}

class GetScreenAnalyticLoadingState extends MyActivityState {
  @override
  List<Object> get props => [];
}

class GetScreenAnalyticSuccessState extends MyActivityState {
  final Map<String, double> mapScreenDuration;

  GetScreenAnalyticSuccessState(this.mapScreenDuration);
  @override
  List<Object> get props => [];
}

class GetScreenAnalyticErrorState extends MyActivityState {
  final String msg;

  GetScreenAnalyticErrorState(this.msg);

  @override
  List<Object> get props => [];
}

//--------------------------------------------------------
class SignupLoadingState extends MyActivityState {
  @override
  List<Object> get props => [];
}

class SignupSuccessState extends MyActivityState {
  @override
  List<Object> get props => [];
}

class SignupErrorState extends MyActivityState {
  final String msg;

  SignupErrorState(this.msg);

  @override
  List<Object> get props => [];
}
