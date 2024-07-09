import 'package:find_food/core/data/prefs/prefs.dart';
import 'package:find_food/features/control_restaurants/restaurant_change_infor/pressentation/controller/restaurant_change_info_controller.dart';
import 'package:get/get.dart';

class RestaurantChangeInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Prefs(), fenix: true);
    Get.lazyPut(() => RestaurantChangeInfoController());
  }
}
