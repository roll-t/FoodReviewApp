import 'package:find_food/core/data/prefs/prefs.dart';
import 'package:find_food/features/account_setting/presentation/controller/account_setting_controller.dart';
import 'package:find_food/features/maps/domain/get_location_case.dart';
import 'package:find_food/features/maps/domain/save_location_case.dart';
import 'package:get/get.dart';

class AccountSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Prefs(), fenix: true);
    Get.lazyPut(() => AccountSettingController(Get.find(), Get.find()));
    Get.lazyPut(() => GetLocationCase(Get.find()));
    Get.lazyPut(() => SaveLoactionCase(Get.find()));
  }
}
