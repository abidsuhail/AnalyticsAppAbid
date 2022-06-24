import 'package:analytics_app/repository/auth_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AuthCubit(this.authRepo) : super(AuthInitial());
  void signUp({required String email, required String password}) async {
    try {
      emit(SignupLoadingState());
      final credential =
          await authRepo.signUp(email: email, password: password);
      emit(SignupSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(SignupErrorState('The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(SignupErrorState('The account already exists for that email.'));
      } else {
        emit(SignupErrorState(e.message ?? "Something went wrong!"));
      }
    } catch (e) {
      emit(SignupErrorState(e.toString()));
    }
  }

  void login({required String email, required String password}) async {
    try {
      emit(LoginLoadingState());
      final credential = await authRepo.login(email: email, password: password);
      emit(LoginSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginErrorState('No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(LoginErrorState('Wrong password provided for that user.'));
      } else {
        emit(LoginErrorState(e.toString()));
      }
    }
  }
}
