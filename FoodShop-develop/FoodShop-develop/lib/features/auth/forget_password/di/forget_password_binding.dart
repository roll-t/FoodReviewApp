import 'package:find_food/core/data/prefs/prefs.dart';
import 'package:find_food/features/auth/forget_password/presentation/controller/forget_password_controller.dart';
import 'package:get/get.dart';

class ForgetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Prefs(), fenix: true);

    Get.lazyPut(() => ForgetPasswordController(Get.find()));
  }
}
