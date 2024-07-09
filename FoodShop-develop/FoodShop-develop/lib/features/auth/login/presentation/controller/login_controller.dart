import 'dart:ffi';

import 'package:find_food/core/configs/enum.dart';
import 'package:find_food/core/data/firebase/firebae_auth/firebase_auth.dart';
import 'package:find_food/core/data/firebase/firestore_database/firestore_user.dart';
import 'package:find_food/core/routes/routes.dart';
import 'package:find_food/core/ui/dialogs/dialogs.dart';
import 'package:find_food/core/ui/snackbar/snackbar.dart';
import 'package:find_food/core/utils/validator.dart';
import 'package:find_food/features/auth/user/domain/use_case/save_user_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final SaveUserUseCase _saveUserUseCase;
  LoginController(this._saveUserUseCase);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // RxBool isEyePassword = true.obs;
  var isEyePassword = true.obs;
  var visiblePassword = true.obs;
  RxString emailError = ''.obs;
  RxString passwordError = ''.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void onInit() {
    super.onInit();
  }

  void toggleIsEyePassword() {
    isEyePassword.value = !isEyePassword.value;
    visiblePassword.value = !visiblePassword.value;
  }

  bool _validateEmail() {
    if (emailController.text.isEmpty) {
      emailError.value = "email_cannot_be_emptyy".tr;
      return false;
    } else if (!Validators.validateEmail(emailController.text)) {
      emailError.value = 'email_invalid';
      return false;
    } else if (passwordController.text.isEmpty) {
      passwordError.value = 'password_cannot_be_empty';
      return false;
    } else {
      passwordError.value = '';
      emailError.value = '';
      return true;
    }
  }

  // void handleLoginWithEmail() async {
  //   print("---------------------OK---------------------");
  //   if (!_validateEmail()) return;
  //   DialogsUtils.showAlterLoading();
  //   final result = await FirebaseAuthentication.logIn(
  //     email: emailController.text, // Sử dụng email từ controller
  //     password: passwordController.text,
  //   );
  //   print("---------------------PROCESSING---------------------");

  //   Get.back();
  //   if (result.status == Status.success) {
  //     User? user = result.data;
  //     print("---------------------CASE   1---------------------");

  //     if (user != null && !user.emailVerified) {
  //       print("---------------------CASE   2---------------------");

  //       await FirebaseAuthentication.sendMailVerify();
  //       Get.offAllNamed(Routes.emailVerify);
  //     } else {
  //       print("---------------------CASE   3---------------------");

  //       final resultUser = await FirestoreUser.getUser(user!.uid);
  //       if (resultUser.status == Status.success) {
  //         if (resultUser.data!.isComplete == false) {
  //           print("---------------------CASE   4---------------------");

  //           Get.offAllNamed(Routes.userInfor, arguments: resultUser.data);
  //         } else {
  //           print("---------------------CASE   5---------------------");

  //           _saveUserUseCase.saveUser(resultUser.data!);
  //           Get.offAllNamed(Routes.main);
  //         }
  //         _saveUserUseCase.saveUser(resultUser.data!);
  //         Get.offAllNamed(Routes.main);
  //       } else {
  //         print("---------------------CASE   FAILS---------------------");

  //         SnackbarUtil.show(result.exp?.message ?? "something_went_wrong");
  //       }
  //     }
  //   }
  // }

  void handleLoginWithEmail() async {
    if (!_validateEmail()) return;
    DialogsUtils.showAlterLoading();
    final result = await FirebaseAuthentication.logIn(
      email: emailController.text,
      password: passwordController.text,
    );

    Get.back();
    if (result.status == Status.success) {
      User? user = result.data;

      final resultUser = await FirestoreUser.getUser(user!.uid);
      if (resultUser.status == Status.success) {
        // if (resultUser.data!.isComplete == false) {
        //   print("---------------------CASE   2---------------------");
        //   Get.offAllNamed(Routes.userInfor, arguments: resultUser.data);
        // } else {
        //   print("---------------------CASE   SUCCESS---------------------");
        //   _saveUserUseCase.saveUser(resultUser.data!);
        //   Get.offAllNamed(Routes.main);
        // }
        print("---------------------CASE   SUCCESS---------------------");

        _saveUserUseCase.saveUser(resultUser.data!);
        Get.offAllNamed(Routes.main);
      } else {}
    } else {
      SnackbarUtil.show(result.exp?.message ?? "something_went_wrong");
    }
  }

  signInWithGoogle() async {
    GoogleAuthProvider.credential(
      accessToken: "",
      idToken: "",
    );
    // FirebaseAuth.instance.signInWithCredential(credential)
  }
}
