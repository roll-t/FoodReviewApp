import 'package:find_food/core/configs/enum.dart';

import 'package:find_food/core/data/firebase/firebae_auth/firebase_auth.dart';
import 'package:find_food/core/data/firebase/firestore_database/firestore_user.dart';

import 'package:find_food/core/ui/snackbar/snackbar.dart';
import 'package:find_food/features/auth/user/domain/use_case/get_user_use_case.dart';
import 'package:find_food/features/auth/user/domain/use_case/save_user_use_case.dart';
import 'package:find_food/features/auth/user/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  final GetuserUseCase _getuserUseCase;
  final SaveUserUseCase _saveUserUseCase;
  ChangePasswordController(this._getuserUseCase, this._saveUserUseCase);
  UserModel? user;

  final formKey = GlobalKey<FormState>();
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  var showPassword = false.obs;

  @override
  void onInit() async {
    user = await _getuserUseCase.getUser();
    super.onInit();
    update(["fetchUserInformation"]);
  }

  Route? onGenerateRoute(Route setting) {
    return null;
  }

  void toggleShowPassword() {
    showPassword.value = !showPassword.value;
    update(["fetchUserInformation"]);
  }

  Future<void> saveNewPassword() async {
    if (user != null) {
      final result = await FirebaseAuthentication.updatePassword(
        newPassword: newPassword.text,
      );

      if (result.status == Status.success) {
        user!.password = newPassword.text;
        await _saveUserUseCase.saveUser(user!);
        await FirestoreUser.updateUser(user!);
        SnackbarUtil.show("Password updated successfully");
        Get.close(1);
      } else {
        SnackbarUtil.show("Failed to update password");
      }
    } else {
      SnackbarUtil.show("User not found");
    }
  }
}
