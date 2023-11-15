import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sleepsounds/core/const/db_names.dart';
import 'package:sleepsounds/core/models/user_model.dart';
import 'package:sleepsounds/src/features/login/domain/states/do_login_states.dart';

abstract class ILoginDatasource {
  Future<IDoLoginStates> doLoginWithEmailAndPassword(
      String email, String password);
  Future<IDoLoginStates> doLoginWithGoogle();
  Future<IDoLoginStates> registerWithEmailAndPassword(
    String email,
    String password,
  );

  Future<IDoLoginStates> insertRegisterDb(
    String email,
    String password,
    UserCredential userCredential,
  );
}

class LoginDatasource extends ILoginDatasource {
  @override
  Future<IDoLoginStates> doLoginWithEmailAndPassword(
      String email, String password) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final result = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return SuccessDataLoginState(credential: result);
    } on FirebaseAuthException catch (e) {
      String message = '';
      switch (e.code) {
        case 'user-not-found':
          message = 'Usuário não encontrado';
        case 'wrong-password':
          message = 'Senha Incorreta';
        case 'invalid-email':
          message = 'Email Invalido';
      }
      return FailureDataLoginState(exception: message.toString());
    } on Exception catch (e) {
      return FailureDataLoginState(exception: e.toString());
    }
  }

  @override
  Future<IDoLoginStates> doLoginWithGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;
      final FirebaseAuth auth = FirebaseAuth.instance;

      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );
      final result = await auth.signInWithCredential(credential);
      return SuccessDataLoginState(credential: result);
    } catch (e) {
      return FailureDataLoginState(exception: e.toString());
    }
  }

  @override
  Future<IDoLoginStates> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final result = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return SuccessDataLoginState(credential: result);
    } catch (e) {
      return FailureDataLoginState(exception: e.toString());
    }
  }

  @override
  Future<IDoLoginStates> insertRegisterDb(
      String email, String password, UserCredential userCredential) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      UserModel userModel = UserModel(
        id: userCredential.user!.uid,
        name: password,
        email: email,
      );
      await firestore
          .collection(AppDbNames.USERS_COLLECTION)
          .doc(userCredential.user!.uid)
          .set(userModel.toMap());

      return SuccessDataLoginState(credential: userCredential);
    } catch (e) {
      return FailureDataLoginState();
    }
  }

  // handleGoogleSignIn() {
  //   GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
  //   auth.signInWithProvider(_googleAuthProvider);
  // }
}
