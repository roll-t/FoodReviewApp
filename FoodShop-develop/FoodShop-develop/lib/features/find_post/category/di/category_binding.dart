
import 'package:find_food/core/data/prefs/prefs.dart';
import 'package:find_food/features/find_post/category/presentation/controller/category_controller.dart';
import 'package:get/get.dart';

class CategoryBinding extends Bindings{
  
  @override
  void dependencies() {
    Get.lazyPut(() => Prefs(), fenix: true);
    Get.lazyPut(()=>CategoryController());
  }

}