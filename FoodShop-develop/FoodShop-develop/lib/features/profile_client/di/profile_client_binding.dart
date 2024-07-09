

import 'package:find_food/core/data/prefs/prefs.dart';
import 'package:find_food/features/profile_client/presentation/controller/profile_client_controller.dart';
import 'package:get/get.dart';

class ProfileClientBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => Prefs(), fenix: true);
    Get.lazyPut(()=>ProfileClientController());
  }

}