import 'package:find_food/core/data/prefs/prefs.dart';
import 'package:find_food/features/auth/login/presentation/controller/login_controller.dart';
import 'package:find_food/features/auth/user/domain/use_case/save_user_use_case.dart';
import 'package:get/get.dart';

class LoginBindding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Prefs(), fenix: true);

    Get.lazyPut(() => SaveUserUseCase(Get.find()));

    Get.lazyPut(() => LoginController(Get.find()));
  }
}
