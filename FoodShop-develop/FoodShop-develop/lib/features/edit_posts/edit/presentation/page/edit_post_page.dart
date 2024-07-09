import 'dart:io';

import 'package:find_food/core/configs/app_colors.dart';
import 'package:find_food/core/configs/app_dimens.dart';
import 'package:find_food/core/ui/widgets/button/button_widget.dart';
import 'package:find_food/core/ui/widgets/loading/loading_data_page.dart';
import 'package:find_food/core/ui/widgets/text/text_widget.dart';
import 'package:find_food/features/edit_posts/edit/presentation/controller/edit_posts_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditPostPage extends GetView<EditPostsController> {
  const EditPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              controller.onClose();
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios,
            ),
          ),
          centerTitle: true,
          title: const Text(
            "EDIT POSTS",
          ),
        ),
        body: GetBuilder<EditPostsController>(
          id: "featchValueEditPostPage",
          builder: (_) {
            return Obx(
              () {
                return controller.isLoading.value
                    ? const LoadingDataPage()
                    : SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 40),
                          child: Column(
                            children: [
                              titleBox(),
                              descriptionBox(),
                              imagesBox(),
                              ButtonUpdate()
                            ],
                          ),
                        ),
                    );
              },
            );
          },
        ));
  }

  // ignore: non_constant_identifier_names
  Container ButtonUpdate() {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: ButtonWidget(ontap: () async{
          controller.isLoading.value=true;
          await controller.updatePosts();
          controller.isLoading.value=false;
          Get.back();
        }, text: "Confirm Update"));
  }

  Column titleBox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleField(title: 'TITLE'),
        TextField(
          controller: controller.titleController,
          decoration: const InputDecoration(
            hintText: "Enter post title",
            hintStyle: TextStyle(
              color: AppColors.grey,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  Column descriptionBox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleField(title: 'DESCRIPTION'),
        Container(
          height: 180,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: TextField(
            controller: controller.subtitleController,
            maxLines: null,
            decoration: const InputDecoration(
                hintText: 'Enter description post',
                border: InputBorder.none,
                hintStyle: TextStyle(fontWeight: FontWeight.w400)),
          ),
        ),
      ],
    );
  }

  Column imagesBox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleField(title: 'IMAGES'),
        Obx(() {
          return Wrap(
            spacing: 15,
            runSpacing: 15,
            children: controller.selectedImagesEdit.map((imagePath) {
              return Stack(
                children: [
                  // Check if the imagePath is a network URL or a local file path
                  imagePath.startsWith('http')
                      ? Image.network(
                          imagePath,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          File(imagePath),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => controller.removeImage(imagePath),
                      child: Container(
                        color: Colors.red,
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          );
        }),
        GestureDetector(
          onTap: () {
            controller.pickImages();
          },
          child: Obx(
            () => Container(
              width: double.infinity,
              margin: !controller.check_list_empty()
                  ? const EdgeInsets.only(top: 10)
                  : null,
              height: controller.check_list_empty() ? 180 : 40,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.gray.withOpacity(0.1),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
                color: AppColors.gray.withOpacity(0.0),
              ),
              child: controller.check_list_empty()
                  ? const Icon(
                      Icons.add_photo_alternate,
                      size: 120,
                    )
                  : const Icon(
                      Icons.add,
                      size: 30,
                      color: AppColors.primary,
                    ),
            ),
          ),
        ),
      ],
    );
  }

  Container titleField({String title = "Please enter title"}) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 10),
      child: TextWidget(
        text: title,
        fontWeight: FontWeight.w300,
        color: AppColors.grayTitle,
        size: AppDimens.textSize16,
      ),
    );
  }
}
