import 'package:find_food/core/data/prefs/prefs.dart';
import 'package:find_food/features/auth/user/domain/use_case/get_user_use_case.dart';
import 'package:find_food/features/control_restaurants/restaurant/pressentation/controller/restaurant_controller.dart';
import 'package:get/get.dart';

class RestaurantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Prefs(), fenix: true);
    Get.lazyPut<RestaurantController>(() => RestaurantController(Get.find()));
  }
}
