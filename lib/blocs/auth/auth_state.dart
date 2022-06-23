import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class LoginLoadingState extends AuthState {
  @override
  List<Object> get props => [];
}

class LoginSuccessState extends AuthState {
  @override
  List<Object> get props => [];
}

class LoginErrorState extends AuthState {
  final String msg;

  LoginErrorState(this.msg);

  @override
  List<Object> get props => [];
}

//--------------------------------------------------------
class SignupLoadingState extends AuthState {
  @override
  List<Object> get props => [];
}

class SignupSuccessState extends AuthState {
  @override
  List<Object> get props => [];
}

class SignupErrorState extends AuthState {
  final String msg;

  SignupErrorState(this.msg);

  @override
  List<Object> get props => [];
}
