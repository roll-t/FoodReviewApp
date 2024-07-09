import 'package:find_food/core/data/prefs/prefs.dart';
import 'package:find_food/features/nav/explore/search/presentation/controller/search_controller.dart';
import 'package:get/get.dart';

class SearchBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => Prefs(), fenix: true);

    Get.lazyPut(() => ExploreController());

  }
}
