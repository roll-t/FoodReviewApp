  import 'package:find_food/core/configs/enum.dart';
  import 'package:find_food/core/data/firebase/firestore_database/firestore_post_data.dart';
  import 'package:find_food/core/ui/snackbar/snackbar.dart';
  import 'package:find_food/features/model/post_data_model.dart';
  import 'package:get/get.dart';

  class ResultSearchController extends GetxController {

    List<PostDataModel> listPost = [];

    var valueSearch = Get.arguments ?? "";

    @override
    void onInit() async {
      super.onInit();
      getPosts(valueSearch);
    }

    void getPosts(String valueSearch) async {
      final result = await FirestorePostData.searchPosts(valueSearch);
      if (result.status == Status.success) {
        listPost = result.data!;
        update(["fetchPosts"]);
      } else {
        SnackbarUtil.show(result.exp!.message ?? "something_went_wrong");
      }
    }
  }
