import 'package:firebase_auth/firebase_auth.dart';
import 'package:sleepsounds/src/features/login/data/login_datasource.dart';
import 'package:sleepsounds/src/features/login/domain/states/do_login_states.dart';

abstract class ILoginRepository {
  Future<IDoLoginStates> doLoginWithEmailAndPassword(
      String email, String password);
  Future<IDoLoginStates> doLoginWithGoogle();
  Future<IDoLoginStates> registerWithEmailAndPassword(
      String email, String password);
  Future<IDoLoginStates> insertRegisterDb(
      String email, String password, UserCredential userCredential);
}

class LoginRepository extends ILoginRepository {
  ILoginDatasource datasource;
  LoginRepository({
    required this.datasource,
  });
  @override
  Future<IDoLoginStates> doLoginWithEmailAndPassword(
      String email, String password) async {
    return await datasource.doLoginWithEmailAndPassword(email, password);
  }

  @override
  Future<IDoLoginStates> doLoginWithGoogle() async {
    return await datasource.doLoginWithGoogle();
  }

  @override
  Future<IDoLoginStates> registerWithEmailAndPassword(
      String email, String password) async {
    return await datasource.registerWithEmailAndPassword(email, password);
  }

  @override
  Future<IDoLoginStates> insertRegisterDb(
      String email, String password, UserCredential userCredential) async {
    return await datasource.insertRegisterDb(email, password, userCredential);
  }
}
