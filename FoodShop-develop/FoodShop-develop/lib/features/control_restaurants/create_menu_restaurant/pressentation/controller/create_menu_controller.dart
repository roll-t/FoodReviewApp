import 'dart:io';

import 'package:find_food/core/configs/enum.dart';
import 'package:find_food/core/data/firebase/firebase_storage/firebase_storage.dart';
import 'package:find_food/core/data/firebase/firestore_database/firestore_menu.dart';
import 'package:find_food/core/ui/snackbar/snackbar.dart';
import 'package:find_food/features/account_setting/nav/create_restaurant/presentation/page/finish_create_restaurant.dart';
import 'package:find_food/features/account_setting/nav/create_restaurant/presentation/page/images_identify_page.dart';
import 'package:find_food/features/account_setting/nav/create_restaurant/presentation/page/license_identify_page.dart';
import 'package:find_food/features/auth/user/domain/use_case/get_user_use_case.dart';
import 'package:find_food/features/auth/user/model/user_model.dart';
import 'package:find_food/features/model/menu_food_restaurant_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreateMenuController extends GetxController {
  final GetuserUseCase _getuserUseCase;
  CreateMenuController(this._getuserUseCase);
  Route? onGenerateRoute(Route setting) {
    return null;
  }

  var idRestaurant = Get.arguments;
  final picker = ImagePicker();
  var selectedImages = <File>[].obs;

  final nameFood = TextEditingController();
  final price = TextEditingController();
  String? restaurantID = "";
  File? imgFood;

  String? pathUrl = "";
  UserModel? user;
  // List<String> listPathUrl = [];
  @override
  void onInit() async {
    user = await _getuserUseCase.getUser();
    super.onInit();
  }

  // Future<void> pickImages() async {
  //   final picker = ImagePicker();
  //   final pickedImages = await picker.pickMultiImage();

  //   selectedImages
  //       .addAll(pickedImages.map((image) => File(image.path)).toList());
  // }

  bool check_list_empty() {
    return selectedImages.length == 0;
  }

  void removeImage(File image) {
    selectedImages.remove(image);
  }

// pick single image
  var backgroundImage = Rxn<File>();

  var imageFood = Rxn<File>();

  final ImagePicker _picker = ImagePicker();

  void pickImage() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (pickedFile != null) {
      imageFood.value = File(pickedFile.path);
    }
  }

  void removeSingleImage() {
    imageFood.value = null;
  }

  Future<String?> uploadFile({required File imageFile}) async {
    if (user == null) {
      SnackbarUtil.show("User not found");
      return null;
    }

    final result = await FirebaseStorageData.uploadImage(
        imageFile: imageFile, userId: user!.uid, collection: "menu_image");

    if (result.status == Status.success) {
      return result.data ?? "";
    } else {
      SnackbarUtil.show(result.exp!.message ?? "something_went_wrong");
      return null;
    }
  }

  void createMenu() async {
    if (pathUrl == null || pathUrl!.isEmpty) {
      pathUrl = await uploadFile(imageFile: imageFood.value!);
    }

    if (pathUrl == null || pathUrl!.isEmpty) {
      SnackbarUtil.show("Failed to upload image");
      return;
    }

    if (nameFood.text.isEmpty || price.text.isEmpty) {
      SnackbarUtil.show("Please fill in all fields");
      return;
    }

    final menu = MenuModel(
      name: nameFood.text,
      price: double.parse(price.text),
      image: pathUrl,
      idRestaurant: idRestaurant,
    );
    print(idRestaurant);
    final result =
        await FirestoreMenu.createMenu(userId: user!.uid, newMenu: menu);
    if (result.status == Status.success) {
      SnackbarUtil.show("Menu created successfully");
      // Reset fields
      nameFood.clear();
      price.clear();
      selectedImages.clear();
      imageFood.value = null;
      pathUrl = "";
    } else {
      SnackbarUtil.show(result.exp!.message ?? "Failed to create menu");
    }
  }
}
