import 'package:find_food/core/data/prefs/prefs.dart';
import 'package:find_food/features/auth/register/presentation/controller/register_controller.dart';
import 'package:get/get.dart';

class RegisterBindding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Prefs(), fenix: true);

    Get.lazyPut(() => RegisterController());
  }
}
