import 'package:find_food/features/auth/user/domain/use_case/save_user_use_case.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  final SaveUserUseCase _saveUserUseCase;
  ForgetPasswordController(this._saveUserUseCase);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void onInit() {
    super.onInit();
  }

  void handleForgetPass() async {
    print("helaaaaao");
  }
}
