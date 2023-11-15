import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sleepsounds/src/features/login/domain/repository/login_repository.dart';
import 'package:sleepsounds/src/features/login/domain/states/do_login_states.dart';

import '../states/login_state.dart';

class LoginController extends ChangeNotifier {
  LoginController({
    required this.repository,
  });
  final FirebaseAuth auth = FirebaseAuth.instance;
  ILoginRepository repository;
  User? user;

  Future<ILoginState> doLoginWithGoogle() async {
    final result = await repository.doLoginWithGoogle();
    if (result is SuccessDataLoginState) {
      return SuccessLoginState();
    } else if (result is FailureDataLoginState) {
      return FailureLoginState(message: result.exception);
    } else {
      return FailureLoginState();
    }
  }

  Future<ILoginState> doLoginWithEmailAndPassword(
      String email, String password) async {
    final result =
        await repository.doLoginWithEmailAndPassword(email, password);
    if (result is SuccessDataLoginState) {
      return SuccessLoginState();
    } else if (result is FailureDataLoginState) {
      return FailureLoginState(message: result.exception);
    } else {
      return FailureLoginState();
    }
  }

  Future<ILoginState> registerWithEmailAndPassword(
      String email, String password) async {
    final result =
        await repository.registerWithEmailAndPassword(email, password);
    if (result is SuccessDataLoginState) {
      final result2 =
          await insertRegisterDb(email, password, result.credential);
      if (result2 is SuccessDataLoginState) {
        return SuccessLoginState();
      } else {
        return FailureLoginState();
      }
    } else if (result is FailureDataLoginState) {
      return FailureLoginState(message: result.exception);
    } else {
      return FailureLoginState();
    }
  }

  Future<ILoginState> insertRegisterDb(
      String email, String password, UserCredential userCredential) async {
    final result = repository.insertRegisterDb(email, password, userCredential);
    if (result is SuccessLoginState) {
      return SuccessLoginState();
    } else {
      return FailureLoginState();
    }
  }

  Future<void> signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      //
    }
  }
}
