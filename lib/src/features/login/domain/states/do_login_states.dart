import 'package:firebase_auth/firebase_auth.dart';

abstract class IDoLoginStates {}

class SuccessDataLoginState extends IDoLoginStates {
  UserCredential credential;
  SuccessDataLoginState({
    required this.credential,
  });
}

class FailureDataLoginState extends IDoLoginStates {
  String? exception;
  FailureDataLoginState({
    this.exception,
  });
}
