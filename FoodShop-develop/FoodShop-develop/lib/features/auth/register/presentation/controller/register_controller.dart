import 'package:find_food/core/configs/enum.dart';
import 'package:find_food/core/data/firebase/firebae_auth/firebase_auth.dart';
import 'package:find_food/core/data/firebase/firestore_database/firestore_user.dart';
import 'package:find_food/core/ui/dialogs/dialogs.dart';
import 'package:find_food/core/ui/snackbar/snackbar.dart';
import 'package:find_food/core/utils/validator.dart';
import 'package:find_food/features/auth/user/model/user_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  RxString msgEmailError = ''.obs;
  RxString msgPasswordError = ''.obs;
  RxString msgConfirmPasswordError = ''.obs;
  var changIconPassword = false.obs;
  var showPassword = false.obs;

  void toggleVisiblePassword() {
    changIconPassword.value = !changIconPassword.value;
    showPassword.value = !showPassword.value;
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool validateEmail() {
    if (emailController.text.isEmpty) {
      msgEmailError.value = 'Email cannot be empty';
      return false;
    } else if (!Validators.validateEmail(emailController.text)) {
      msgEmailError.value = 'Email invalid';
      return false;
    } else {
      msgEmailError.value = '';
      return true;
    }
  }

  bool validatePassword() {
    if (passwordController.text.isEmpty) {
      msgPasswordError.value = 'password_cannot_be_empty';
      return false;
    } else if (!Validators.validPassword(passwordController.text)) {
      msgPasswordError.value = 'Password must be 6-20 characters long';
      return false;
    } else if (confirmPasswordController.text.isNotEmpty &&
        passwordController.text != confirmPasswordController.text) {
      msgConfirmPasswordError.value = 'Passwords_do_not_match';
      return false;
    } else {
      msgPasswordError.value = '';
      msgConfirmPasswordError.value = '';
      return true;
    }
  }

  void register() async {
    if (!validateEmail() || !validatePassword()) {
      return;
    }
    // DialogsUtils.showAlterLoading();
    final result = await FirebaseAuthentication.signUp(
      email: emailController.text,
      password: passwordController.text,
    );

    if (result.status == Status.success) {
      UserModel user = UserModel(
        uid: result.data!.uid,
        email: result.data!.email!,
      );
      DialogsUtils.showAlertDialog2(
          title: "Đăng ký thành công",
          message: "Bạn sẽ được chuyển đến trang đăng nhập",
          typeDialog: TypeDialog.success,
          onPresss: () async =>
              {await createNewUser(user), Get.offAllNamed("/login")});
    } else {
      Get.back();
      if (result.exp?.code == "email-already-in-use") {
        msgEmailError.value = 'email_already_in_use';
        return;
      }

      SnackbarUtil.show(result.exp?.message ?? "something_went_wrong");
    }
  }

  createNewUser(UserModel user) async {
    final result = await FirestoreUser.createUser(user);
    if (result.status == Status.success) {
      Get.back();
      // Get.offAllNamed(Routes.emailVerify);
    } else {
      Get.back();
      SnackbarUtil.show(result.exp?.message ?? "something_went_wronggg");
    }
  }
}
