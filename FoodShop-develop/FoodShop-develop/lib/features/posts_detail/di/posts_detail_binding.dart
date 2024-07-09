import 'package:find_food/core/data/prefs/prefs.dart';
import 'package:find_food/features/posts_detail/presentation/controller/posts_detail_controller.dart';
import 'package:get/get.dart';

class PostsDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Prefs(), fenix: true);
    Get.lazyPut(() => PostsDetailController(Get.find()));
  }
}
