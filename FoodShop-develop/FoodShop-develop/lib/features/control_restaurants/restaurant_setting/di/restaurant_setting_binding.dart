import 'package:find_food/core/data/prefs/prefs.dart';
import 'package:find_food/features/control_restaurants/restaurant_setting/pressentation/controller/restaurant_setting_controller.dart';
import 'package:get/get.dart';

class RestaurantSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Prefs(), fenix: true);
    Get.lazyPut<RestaurantSettingController>(
        () => RestaurantSettingController());
  }
}
