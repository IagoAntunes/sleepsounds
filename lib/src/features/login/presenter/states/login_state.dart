abstract class ILoginState {}

class SuccessLoginState extends ILoginState {}

class FailureLoginState extends ILoginState {
  String? message;
  FailureLoginState({
    this.message,
  });
}
