import 'package:find_food/core/configs/enum.dart';
import 'package:find_food/core/data/firebase/firestore_database/firestore_post_data.dart';
import 'package:find_food/core/services/location_service.dart';
import 'package:find_food/core/ui/snackbar/snackbar.dart';
import 'package:find_food/features/maps/location/models/place_map.dart';
import 'package:find_food/features/model/post_data_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExploreController extends GetxController {
  
  List<PostDataModel> listPost = [];

  List<PostDataModel> listPostArea = [];

  List<PostDataModel> listPostFavorite = [];

  final searchText = TextEditingController();

  final LocationService locationService = Get.find<LocationService>();

  PlaceMap? place;

  var isLoading=false.obs;
 

  @override
  void onInit() async {
    super.onInit();
    isLoading.value=true;
    place = await locationService.getLocation();
    await getPosts();
    isLoading.value=false;
    update(["fetchDataExplorepage"]);
  }

   Future<void>  refreshPage() async{
    await getPosts();
    update(["fetchDataExplorepage"]);
  }
   Future<void> getPosts() async {
    final result = await FirestorePostData.getListPostRelate(limit: 5);
    final resultArea = await FirestorePostData.getListPostRelate(limit:5);
    final resultFavorite = await FirestorePostData.getListPostRelate(limit: 8);

    if (result.status == Status.success) {
      listPost = result.data!;
      listPostArea = resultArea.data!;
      listPostFavorite = resultFavorite.data!;
      update(["fetchPosts"]);
    } else {
      SnackbarUtil.show(result.exp!.message ?? "something_went_wrong");
    }
  }
}
