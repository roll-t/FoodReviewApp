import 'dart:async';
import 'package:find_food/core/configs/enum.dart';
import 'package:find_food/core/data/firebase/firestore_database/firestore_favorite.dart';
import 'package:find_food/core/data/prefs/prefs.dart';
import 'package:find_food/core/services/location_service.dart';
import 'package:find_food/core/utils/calculator_utils.dart';
import 'package:find_food/features/auth/user/domain/use_case/get_user_use_case.dart';
import 'package:find_food/features/auth/user/model/user_model.dart';
import 'package:find_food/features/model/favorite_model.dart';
import 'package:find_food/features/model/post_data_model.dart';
import 'package:get/get.dart';

class PostCardController extends GetxController {
  bool isFavorited = false;
  bool isProcessing = false;
  final LocationService locationService = Get.find<LocationService>();

  List<dynamic> listPostUserFavorite = [];

  var distance = 0.0;

  final Prefs prefs = Prefs.preferences;

  UserModel? author;

  var isFavorite = false.obs;

  int countFavorites = 0;

  @override
  void onInit() async {
    super.onInit();
    await _initializeFavoriteState();
  }

  _initializeFavoriteState() async {
    GetuserUseCase user = GetuserUseCase(prefs);
    author = await user.getUser();
    if (author != null) {}
    await getListPostsUserFavorite();
    update(['updateStateInteractive']);
  }

  getListPostsUserFavorite() async {
    var result = await FirestoreFavorite.getPostsFavoritedByUser(author!.uid ?? "");
    if (result.status == Status.success) {
      listPostUserFavorite = result.data ?? [];
    }
  }

  Future<int> getCountFavorite(String postId) async {
    return await FirestoreFavorite.countFavoritesByPostId(postId);
  }

  Future<void> toggleFavoriteState(
      {required PostDataModel posts, required bool stateIcon}) async {
    isProcessing = true;
    if (stateIcon) {
      await FirestoreFavorite.createFavorite(FavoriteModel(
          author: author, posts: posts, createdAt: DateTime.now().toString()));
    } else {
      await FirestoreFavorite.deleteFavoriteByUserAndPostId(
          userId: author!.uid, postId: posts.id ?? "");
    }
    await getListPostsUserFavorite();
    isProcessing = false;
    // update([posts.id ?? ""]);
  }

  Future<double> distanceCalculate({required PostDataModel postsData}) async {
    var placeMap = await locationService.getLocation();
    if (placeMap != null) {
      double placeLat = placeMap.lat ?? 0.0;
      double placeLon = placeMap.lon ?? 0.0;
      double postLat = postsData.latitude ?? 0.0;
      double postLon = postsData.longitude ?? 0.0;
      double distance = CalculatorUtils.calculateDistance(
        placeLat,
        placeLon,
        postLat,
        postLon,
      );
      distance = double.parse(distance.toStringAsFixed(2));
      return double.parse(distance.toStringAsFixed(2));
    }
    return 0.0;
  }
}
