import 'dart:io';

import 'package:find_food/core/configs/enum.dart';
import 'package:find_food/core/data/firebase/firebase_storage/firebase_storage.dart';
import 'package:find_food/core/data/firebase/firestore_database/firestore_post_data.dart';
import 'package:find_food/core/ui/snackbar/snackbar.dart';
import 'package:find_food/features/auth/user/domain/use_case/get_user_use_case.dart';
import 'package:find_food/features/auth/user/model/user_model.dart';
import 'package:find_food/features/main/presentation/controller/main_controller.dart';
import 'package:find_food/features/maps/location/models/place_map.dart';
import 'package:find_food/features/model/post_data_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class UploadController extends GetxController {
  final MainController _mainController = Get.find();

  final GetuserUseCase _getuserUseCase;

  UploadController(this._getuserUseCase);

  var selectedImages = <File>[].obs;

  final titleController = TextEditingController();

  final descriptionController = TextEditingController();

  PlaceMap placeSelected = PlaceMap();

  UserModel? user;

  bool attchLocation = false;

  var nameLocationDisplay = "".obs;

  List<String> listPathUrl = [];

  @override
  void onInit() async {
    user = await _getuserUseCase.getUser();
    super.onInit();
  }

  Future<void> pickImages() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage();

    selectedImages
        .addAll(pickedImages.map((image) => File(image.path)).toList());
  }

  savePost() async {
    _mainController.isLoading.value = true;
    if (listPathUrl.isEmpty) {
      for (var file in selectedImages) {
        String? pathUrl = await uploadFile(imageFile: file);
        if (pathUrl != null) {
          listPathUrl.add(pathUrl);
        }
      }
    }

    final post = PostDataModel(
        title: titleController.text,
        subtitle: descriptionController.text.trim(),
        imageList: listPathUrl,
        restaurantId: '',
        createAt: DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(DateTime.now()),
        latitude: placeSelected.lat ?? 0.0,
        longitude: placeSelected.lon ?? 0.0,
        placeMap: placeSelected.toJson(),
        status: StatusPosts.waiting
        );

    final result = await FirestorePostData.savedPost(
        postDataModel: post, userId: user!.uid);
    if (result.status == Status.success) {
      listPathUrl.clear();
      selectedImages.clear();
      titleController.text = "";
      descriptionController.text = "";
      nameLocationDisplay.value = "";
      update();
      Fluttertoast.showToast(msg: "Add post success".tr);
    } else {
      Fluttertoast.showToast(msg: "Add post error".tr);
    }
    _mainController.isLoading.value = false;
  }

  // ignore: non_constant_identifier_names
  bool check_list_empty() {
    return selectedImages.isEmpty;
  }

  Future<String?> uploadFile({required File imageFile}) async {
    String? pathUrl;
    final result = await FirebaseStorageData.uploadImage(
        imageFile: imageFile, userId: user!.uid, collection: "post_images");
    if (result.status == Status.success) {
      pathUrl = result.data ?? "";
    } else {
      SnackbarUtil.show(result.exp!.message ?? "something_went_wrong");
    }
    return pathUrl;
  }

  void removeImage(File image) {
    selectedImages.remove(image);
  }

  void uploadPost() {
    if (selectedImages.isEmpty) {
      Fluttertoast.showToast(msg: "Please select an image for the posts");
      return;
    }
    if (titleController.text == "") {
      Fluttertoast.showToast(msg: "Titile Can't be empty");
      return;
    }

    if (descriptionController.text == "") {
      Fluttertoast.showToast(msg: "Description Can't be empty");
      return;
    }

    if (!placeSelected.allow()) {
      Fluttertoast.showToast(msg: "Please select address");
      return;
    }

    savePost();
  }
}
