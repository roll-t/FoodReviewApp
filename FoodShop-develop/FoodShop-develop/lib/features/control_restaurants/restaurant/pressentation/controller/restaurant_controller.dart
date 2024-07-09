import 'dart:io';

import 'package:find_food/core/configs/enum.dart';
import 'package:find_food/core/data/firebase/firestore_database/firestore_menu.dart';
import 'package:find_food/core/data/firebase/firestore_database/firestore_restaurant.dart';
import 'package:find_food/core/ui/snackbar/snackbar.dart';
import 'package:find_food/features/auth/user/domain/use_case/get_user_use_case.dart';
import 'package:find_food/features/auth/user/model/user_model.dart';
import 'package:find_food/features/model/menu_food_restaurant_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RestaurantController extends GetxController {
  var isLoading = false.obs;
  var itemsToShow = 4.obs;
  var itemHide = false.obs;

  final picker = ImagePicker();
  File? imgAvatar;
  File? imgWallpapper;
  UserModel? user;
  String nameRestaurant = "";
  String emailRestaurant = "";
  String phoneRestaurant = "";
  String addressRestaurant = "";
  String avatarUrl = "";
  String backgroundUrl = "";
  String idRestaurant = "";
  File? foodImage;
  final TextEditingController foodName = TextEditingController();
  final TextEditingController foodPrice = TextEditingController();

  String? foodImagePath = "";

  List<MenuModel> listFood =[];

  final GetuserUseCase _getuserUseCase;
  RestaurantController(this._getuserUseCase);

  @override
  void onInit() async {
    isLoading.value = true;
    user = await _getuserUseCase.getUser();
    await getRestaurantData();
    await getMenuOfRestaurant();
    super.onInit();
    isLoading.value = false;
  }

  refreshPage() async {
    user = await _getuserUseCase.getUser();
    await getRestaurantData();
    await getMenuOfRestaurant();
  }

  Future selectImageAvatarGallery() async {
    final pickFileImg =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (pickFileImg != null) {
      imgAvatar = File(pickFileImg.path);
      update(['updateAvatar']);
    }
  }

  Future selectImageWallpaper() async {
    final pickFileImg =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (pickFileImg != null) {
      imgWallpapper = File(pickFileImg.path);
      update(['updateWallpaper']);
    }
  }

  void hideItems() {
    itemsToShow.value = 4;
    itemHide.value = false;
  }

  Future<void> getRestaurantData() async {
    final result = await FirestoreRestaurant.getRestaurant(user!.uid);
    if (result.status == Status.success) {
      final restaurant = result.data;
      nameRestaurant = restaurant!.nameRestaurant!.toString();
      emailRestaurant = restaurant.emailRestaurant!;
      phoneRestaurant = restaurant.phoneRestaurant!;
      addressRestaurant = restaurant.addressRestaurant!;
      avatarUrl = restaurant.avatarUrl!;
      backgroundUrl = restaurant.backgroundUrl!;
      idRestaurant = restaurant.idRestaurant!;
      update(["getInforRestaurant"]);
    } else {
      SnackbarUtil.show(result.exp!.message ?? "something_went_wrong");
    }
  }

  Future<void> getMenuOfRestaurant() async {
    final result = await FirestoreMenu.getMenu(restaurantID: idRestaurant);
    if (result.status == Status.success) {
      listFood = result.data ?? [];
      update(["getMenuOfRestaurant"]);
    } else {
      SnackbarUtil.show(result.exp!.message ?? "something_went_wrong");
    }
  }
}
