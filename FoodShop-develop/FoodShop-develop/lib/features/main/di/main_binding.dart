import 'package:find_food/core/data/prefs/prefs.dart';
import 'package:find_food/features/auth/user/domain/use_case/get_user_use_case.dart';
import 'package:find_food/features/main/presentation/controller/main_controller.dart';
import 'package:get/get.dart';

class MainBindding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => Prefs(), fenix: true);
    Get.lazyPut(() => MainController(Get.find(),Get.find()));
    Get.lazyPut(() => GetuserUseCase(Get.find()));

  }
}
