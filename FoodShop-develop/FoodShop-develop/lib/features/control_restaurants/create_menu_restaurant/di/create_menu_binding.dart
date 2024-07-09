import 'package:find_food/core/data/prefs/prefs.dart';
import 'package:find_food/features/auth/user/domain/use_case/get_user_use_case.dart';
import 'package:find_food/features/control_restaurants/create_menu_restaurant/pressentation/controller/create_menu_controller.dart';
import 'package:get/get.dart';

class CreateMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Prefs());
    Get.lazyPut(() => CreateMenuController(Get.find()));
    Get.lazyPut(() => GetuserUseCase(Get.find()));
  }
}
