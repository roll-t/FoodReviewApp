import 'dart:io';

import 'package:find_food/core/configs/enum.dart';
import 'package:find_food/core/data/firebase/firebase_storage/firebase_storage.dart';
import 'package:find_food/core/data/firebase/firestore_database/firestore_restaurant.dart';
import 'package:find_food/core/ui/snackbar/snackbar.dart';
import 'package:find_food/features/account_setting/nav/create_restaurant/presentation/page/finish_create_restaurant.dart';
import 'package:find_food/features/account_setting/nav/create_restaurant/presentation/page/images_identify_page.dart';
import 'package:find_food/features/account_setting/nav/create_restaurant/presentation/page/license_identify_page.dart';
import 'package:find_food/features/auth/user/domain/use_case/get_user_use_case.dart';
import 'package:find_food/features/auth/user/model/user_model.dart';
import 'package:find_food/features/model/restaurant_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreateRestaurantController extends GetxController {
  Route? onGenerateRoute(Route setting) {
    return null;
  }

  

  var isLoading=false.obs;

  List<Widget> getPages() {
    return [
      const LicenseIdentifyPage(),
      const ImagesIdentifyPage(),
      const FinishCreateRestaurantPage(),
    ];
  }

  final GetuserUseCase _getuserUseCase;
  CreateRestaurantController(this._getuserUseCase);

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  UserModel? user;

  var licenseRestaurant = <File>[].obs;
  var ownerLicenseImages = <File>[].obs;

  File? restaurantBackgroundImages;
  File? restaurantLogoImages;

  final nameRestaurant = TextEditingController();
  final emailRestaurant = TextEditingController();
  final phoneRestaurant = TextEditingController();
  final addressRestaurant = TextEditingController();

  List<String> listPathUrl = [];
  List<String> listPathLisenceRestaurant = [];
  List<String> listPathOwnerLicenseImages = [];
  @override
  void onInit() async {
    user = await _getuserUseCase.getUser();
    super.onInit();
  }

  Future<void> saveRestaurant() async {
    if (listPathLisenceRestaurant.isEmpty) {
      for (var file in licenseRestaurant) {
        String? pathUrl = await uploadFile(imageFile: file);
        if (pathUrl != null) {
          listPathLisenceRestaurant.add(pathUrl);
        }
      }
    }
    if (listPathOwnerLicenseImages.isEmpty) {
      for (var file in ownerLicenseImages) {
        String? pathUrl = await uploadFile(imageFile: file);
        if (pathUrl != null) {
          listPathOwnerLicenseImages.add(pathUrl);
        }
      }
    }
    String? pathBackgroundImages =
        await uploadFile(imageFile: restaurantBackgroundImages!);
    String? pathLogoImages = await uploadFile(imageFile: restaurantLogoImages!);

    final restaurant = RestaurantModel(
      nameRestaurant: nameRestaurant.text,
      emailRestaurant: emailRestaurant.text,
      phoneRestaurant: phoneRestaurant.text,
      addressRestaurant: addressRestaurant.text,
      backgroundUrl: pathBackgroundImages,
      avatarUrl: pathLogoImages,
      licenseRestaurant: listPathLisenceRestaurant,
      onwnerLicenseImages: listPathOwnerLicenseImages,
      status: StatusPosts.waiting
    );

    final result = await FirestoreRestaurant.createRestaurant(newRestaurant: restaurant, userId: user!.uid);
    if (result.status == Status.success) {
      Fluttertoast.showToast(msg: "Create Restaurant Success ");
    } else {
      SnackbarUtil.show(result.exp!.message ?? "something_went_wrong");
    }
  }

  Future<String?> uploadFile({required File imageFile}) async {
    String? pathUrl;
    final result = await FirebaseStorageData.uploadImage(
        imageFile: imageFile, userId: user!.uid, collection: "Lisencse Image");
    if (result.status == Status.success) {
      pathUrl = result.data ?? "";
    } else {
      SnackbarUtil.show(result.exp!.message ?? "something_went_wrong");
    }
    return pathUrl;
  }

  Future<void> pickImages(List selectedImages) async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage();
    selectedImages
        .addAll(pickedImages.map((image) => File(image.path)).toList());
  }

  // ignore: non_constant_identifier_names
  bool check_list_empty(List selectedImages) {
    return selectedImages.isEmpty;
  }

  void removeImage(List imageVerify, File image) {
    imageVerify.remove(image);
  }

// pick single image
  File? backgroundImage;

  File? logoImage;

  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      update(["clearData"]);
      return File(pickedFile.path);
    } else {
      return null;
    }
  }

  void removeSingleImage(File? file) {
    file = null;
    update(["clearData"]);
  }

  void controlCreateRestaurant() {
    if (nameRestaurant.text.isEmpty ||
        emailRestaurant.text.isEmpty ||
        phoneRestaurant.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill in all the information");
    } else {
      Get.to(() => const LicenseIdentifyPage());
    }
  }

  void controlLicenseIdentify() {
    if (licenseRestaurant.isEmpty || ownerLicenseImages.isEmpty) {
      Fluttertoast.showToast(msg: "Please select an image for the posts");
      return;
    }
    
    if (addressRestaurant.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill the address of the restaurant");
      return;
    }
    Get.to(() => const ImagesIdentifyPage());
  }

  Future<void> createRestaurant()async {
    if (restaurantBackgroundImages == null || restaurantLogoImages == null) {
      Fluttertoast.showToast(msg: "Please select an image for the posts");
      return;
    } else {
      isLoading.value=true;
      await saveRestaurant();
      isLoading.value=false;
      Get.to(() => const FinishCreateRestaurantPage());
    }
  }

  Future<void> getRestaurantData() async {
    final result = await FirestoreRestaurant.getRestaurant(user!.uid);
    if (result.status == Status.success) {
      final restaurant = result.data;
      nameRestaurant.text = restaurant!.nameRestaurant!;
      emailRestaurant.text = restaurant.emailRestaurant!;
      phoneRestaurant.text = restaurant.phoneRestaurant!;
      addressRestaurant.text = restaurant.addressRestaurant!;
      listPathUrl = restaurant.licenseRestaurant!;
    } else {
      SnackbarUtil.show(result.exp!.message ?? "something_went_wrong");
    }
  }
}
