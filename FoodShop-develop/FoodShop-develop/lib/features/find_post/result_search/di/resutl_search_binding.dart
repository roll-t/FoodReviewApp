
import 'package:find_food/core/data/prefs/prefs.dart';
import 'package:find_food/features/find_post/result_search/presentation/controller/result_search_controller.dart';
import 'package:get/get.dart';

class ResultSearchBinding extends Bindings{
  
  @override
  void dependencies() {
    Get.lazyPut(() => Prefs(), fenix: true);
    Get.lazyPut(()=>ResultSearchController());

  }

}