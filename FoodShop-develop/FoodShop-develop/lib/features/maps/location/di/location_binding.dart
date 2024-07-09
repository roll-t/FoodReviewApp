import 'package:find_food/core/data/prefs/prefs.dart';
import 'package:find_food/features/maps/location/presentation/controller/location_controller.dart';
import 'package:get/get.dart';

class LocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Prefs(), fenix: true);
    Get.lazyPut(() => LocationController());
  }
}
