import 'package:find_food/core/configs/enum.dart';
import 'package:find_food/core/data/firebase/firestore_database/firestore_post_data.dart';
import 'package:find_food/core/data/firebase/firestore_database/firestore_restaurant.dart';
import 'package:find_food/core/data/firebase/firestore_database/firestore_user.dart';
import 'package:find_food/features/auth/user/model/user_model.dart';
import 'package:find_food/features/model/post_data_model.dart';
import 'package:get/get.dart';

class ProfileClientController extends GetxController {
  var dataArgument = Get.arguments;

  UserModel? user;

  List<PostDataModel>? listPosts;

  var isRestaurant = false.obs;

  var isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    isLoading.value=true;
    await getAuthorPost();
    if (user != null) {
      await getListPostsByIdUser(uid: user?.uid ?? "");
      await checkRestaurant(uid: user?.uid ?? "");
      
    }
    isLoading.value=false;
  }

  getListPostsByIdUser({required String uid}) async {
    var result = await FirestorePostData.getListPostOfUser(uid);
    if (result.status == Status.success) {
      listPosts = result.data;
    }
  }

  checkRestaurant({required String uid}) async {
    var result = await FirestoreRestaurant.getRestaurant(uid);
    if (result.status == Status.success) {
      isRestaurant.value = true;
    } else {
      isRestaurant.value = false;
    }
  }

  getAuthorPost() async {
    if (dataArgument['idAuthor'] != null) {
      final result = await FirestoreUser.getUser(dataArgument['idAuthor']);
      if (result.status == Status.success) {
        user = result.data;
      }
    }
  }
}
