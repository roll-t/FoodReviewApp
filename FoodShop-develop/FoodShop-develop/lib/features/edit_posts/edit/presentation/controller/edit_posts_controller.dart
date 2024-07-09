import 'dart:io';

import 'package:find_food/core/configs/enum.dart';
import 'package:find_food/core/data/firebase/firebase_storage/firebase_storage.dart';
import 'package:find_food/core/data/firebase/firestore_database/firestore_post_data.dart';
import 'package:find_food/core/ui/snackbar/snackbar.dart';
import 'package:find_food/features/model/post_data_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditPostsController extends GetxController {
  PostDataModel? dataArguments;
  PostDataModel? dataPosts;
  TextEditingController? titleController;
  TextEditingController? subtitleController;
  var selectedImagesEdit = <String>[].obs;

  var isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;
    dataArguments = Get.arguments;
    var idPost = dataArguments?.id ?? "0";
    await fetchData(idPost);
    isLoading.value = false;
  }

  Future<void> fetchData(String idPost) async {
    final result = await FirestorePostData.getPost(idPost);
    if (result.data != null) {
      dataPosts = result.data;
      titleController = TextEditingController(text: dataPosts?.title);
      subtitleController = TextEditingController(text: dataPosts?.subtitle);
      // Convert image paths (String) to File objects
      if (dataPosts?.imageList != null) {
        selectedImagesEdit.value = dataPosts?.imageList ?? [];
      }
      update(['featchValueEditPostPage']);
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }

  Future<void> pickImages() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage();
    selectedImagesEdit.addAll(pickedImages.map((image) => image.path).toList());
  }

  // ignore: non_constant_identifier_names
  bool check_list_empty() {
    return selectedImagesEdit.isEmpty;
  }

  

  Future<String?> uploadFile({required File imageFile}) async {
    String? pathUrl;
    final result = await FirebaseStorageData.uploadImage(
        imageFile: imageFile,
        userId: dataPosts?.userId ?? "",
        collection: "post_images");
    if (result.status == Status.success) {
      pathUrl = result.data ?? "";
    } else {
      Fluttertoast.showToast(
          msg: result.exp!.message ?? "something_went_wrong");
    }
    return pathUrl;
  }

  void removeImage(dynamic image) {
    selectedImagesEdit.remove(image);
  }

//Update the user's avatar in Firestore
  Future<void> updatePosts() async {
    if (titleController?.text == null || dataPosts == null) return;

    List<dynamic> listImagesUpload = [];

    List<String> valueOrigin = [];
    
    for (var image in selectedImagesEdit) {
        if (!image.startsWith("http")) {
          listImagesUpload.add(image);
        } else {
          valueOrigin.add(image);
        }
      }

    if (listImagesUpload.isNotEmpty) {
      for (var file in listImagesUpload) {
        String? pathUrl = await uploadFile(imageFile: File(file));
        if (pathUrl != null) {
          valueOrigin.add(pathUrl);
        }
      }
    }

    final result = await FirestorePostData.updatePost(PostDataModel(
        id: dataPosts?.id,
        title: titleController?.text,
        subtitle: subtitleController?.text,
        createAt: dataPosts?.createAt,
        userId: dataPosts?.userId,
        imageList: valueOrigin,
        latitude: dataPosts?.latitude,
        longitude: dataPosts?.longitude,
        restaurantId: dataPosts?.restaurantId,
        placeMap: dataPosts?.placeMap,
        status: dataPosts?.status
        ));
        
    if (result.status == Status.success) {
      Fluttertoast.showToast(msg: "Post updated successfully");
    } else {
      SnackbarUtil.show(result.exp?.message ?? "Something went wrong");
    }
  }
}
