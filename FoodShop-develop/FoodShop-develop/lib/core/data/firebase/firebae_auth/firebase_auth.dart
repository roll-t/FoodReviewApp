import 'package:find_food/core/data/firebase/model/result.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthentication {
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  get user => firebaseAuth.currentUser;

  static Future<Result<User>> signUp(
      {required String email, required String password}) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await firebaseAuth.currentUser!.sendEmailVerification();
      return Result.success(credential.user);
    } on FirebaseAuthException catch (e) {
      return Result.error(e);
    }
  }

  static Future<Result<User>> logIn(
      {required String email, required String password}) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return Result.success(credential.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == "INVALID_LOGIN_CREDENTIALS") {
        return Result.error(FirebaseException(
            code: "INVALID_LOGIN_CREDENTIALS",
            message: "login_failed",
            plugin: ""));
      } else {
        return Result.error(e);
      }
    }
  }

  static Future<Result<User>> sendMailVerify() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        return Result.success(user);
      } else {
        return Result.error(FirebaseAuthException(
            code: "email_verified", message: "Email is verified"));
      }
    } on FirebaseAuthException catch (e) {
      return Result.error(e);
    }
  }

  static Future<bool> isThisEmailToken({required String email}) async {
    List<String> data = await firebaseAuth.fetchSignInMethodsForEmail(email);

    return data.isNotEmpty;
  }

  static Future signOut() async => await firebaseAuth.signOut();

  static Future<Result<void>> updatePassword({
    required String newPassword,
  }) async {
    try {
      User? user = firebaseAuth.currentUser;
      if (user != null) {
        await user.updatePassword(newPassword);
        return Result.success(user);
      } else {
        return Result.error(FirebaseAuthException(
          code: "no-current-user",
          message: "No user currently signed in",
        ));
      }
    } on FirebaseAuthException catch (e) {
      return Result.error(e);
    }
  }
}
