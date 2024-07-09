
import 'package:find_food/core/data/prefs/prefs.dart';
import 'package:find_food/features/edit_posts/edit/presentation/controller/edit_posts_controller.dart';
import 'package:get/get.dart';

class EditPostsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => Prefs(), fenix: true);
    Get.lazyPut(()=>EditPostsController());
  }

}


