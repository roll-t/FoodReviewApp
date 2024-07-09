import 'package:find_food/core/data/prefs/prefs.dart';
import 'package:find_food/features/account_setting/nav/create_restaurant/presentation/controller/create_restaurant_controller.dart';
import 'package:find_food/features/auth/user/domain/use_case/get_user_use_case.dart';
import 'package:get/get.dart';

class CreateRestaurantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Prefs(), fenix: true);
    Get.lazyPut(() => CreateRestaurantController(Get.find()));
    Get.lazyPut(() => GetuserUseCase(Get.find()));
  }
}
