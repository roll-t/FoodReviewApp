
import 'package:find_food/core/data/prefs/prefs.dart';
import 'package:find_food/features/location_restaurant/presentation/controller/location_restaurant_controller.dart';
import 'package:get/get.dart';

class LocationRestaurantBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => Prefs(), fenix: true);
    Get.lazyPut(() => LocationRestaurantController(), fenix: true);
  }

}