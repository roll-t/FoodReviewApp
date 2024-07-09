import 'package:find_food/core/configs/enum.dart';
import 'package:find_food/core/data/firebase/firestore_database/firestore_user.dart';
import 'package:find_food/core/ui/snackbar/snackbar.dart';
import 'package:find_food/features/auth/user/domain/use_case/get_user_use_case.dart';
import 'package:find_food/features/auth/user/domain/use_case/save_user_use_case.dart';
import 'package:find_food/features/auth/user/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class SettingInformationController extends GetxController {
  final GetuserUseCase _getuserUseCase;
  final SaveUserUseCase _saveUserUseCase;
  SettingInformationController(this._getuserUseCase, this._saveUserUseCase);
  UserModel? user;

  var isChangeValue = false;

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() async {
    user = await _getuserUseCase.getUser();
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    update(["setting_information_controller", "fetchUserInformation"]);
  }

  Future<void> getUser() async {
    user = await _getuserUseCase.getUser();
    if (user != null) {
      update(["fetchUserInformation"]);
    } else {
      SnackbarUtil.show("Failed to load user information");
    }
  }



  Future<void> updateUser() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (isChangeValue) {
        await _saveUserUseCase.saveUser(user!);
        final result = await FirestoreUser.updateUser(user!);
        if (result.status == Status.success) {
          SnackbarUtil.show("Save changes");
          isChangeValue = false;
        } else {
          SnackbarUtil.show("Something went wrong");
        }
      }else{
          Fluttertoast.showToast(msg:"Please enter the information you want to change");
      }
      update(["fetchUserInformation"]);
    } else {
      SnackbarUtil.show("Validation failed");
    }
  }
}
