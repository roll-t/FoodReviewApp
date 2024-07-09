import 'package:find_food/core/data/prefs/prefs.dart';
import 'package:find_food/features/control_restaurants/restaurant_social_network/pressentation/controller/restaurant_social_network_controller.dart';
import 'package:get/get.dart';

class RestaurantSocialNetworkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Prefs(), fenix: true);
    Get.lazyPut(() => RestaurantSocialNetworkController());
  }
}
