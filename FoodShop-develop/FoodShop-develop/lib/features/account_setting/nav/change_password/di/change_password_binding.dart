import 'package:find_food/core/data/prefs/prefs.dart';
import 'package:find_food/features/account_setting/nav/change_password/presentation/controller/change_password_controller.dart';
import 'package:find_food/features/auth/user/domain/use_case/get_user_use_case.dart';
import 'package:find_food/features/auth/user/domain/use_case/save_user_use_case.dart';
import 'package:get/get.dart';

class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Prefs(), fenix: true);
    Get.lazyPut(() => GetuserUseCase(Get.find()));
    Get.lazyPut(() => SaveUserUseCase(Get.find()));
    Get.lazyPut(() => ChangePasswordController(Get.find(), Get.find()));
  }
}
