import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  static AuthRepo? _mInstance;

  static AuthRepo getInstance() {
    _mInstance ??= AuthRepo();
    return _mInstance!;
  }

  Future<UserCredential> signUp(
      {required String email, required String password}) async {
    return await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> login(
      {required String email, required String password}) async {
    return await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }
}
