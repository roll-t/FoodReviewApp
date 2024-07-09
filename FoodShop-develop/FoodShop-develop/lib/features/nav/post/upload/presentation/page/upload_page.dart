
import 'package:find_food/core/configs/app_colors.dart';
import 'package:find_food/core/configs/app_dimens.dart';
import 'package:find_food/core/routes/routes.dart';
import 'package:find_food/core/ui/widgets/appbar/upload_post_appbar.dart';
import 'package:find_food/core/ui/widgets/button/button_widget.dart';
import 'package:find_food/core/ui/widgets/text/text_widget.dart';
import 'package:find_food/features/nav/post/upload/presentation/controller/upload_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//streamCotroller, StreamBuilder

class UploadPage extends GetView<UploadController> {
  const UploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UploadPostAppbar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
              child: GetBuilder<UploadController>(
                id: "clearData",
                builder: (logic) {
                  return Column(
                    children: [
                      // Image Picker
                      imagesBox(),
                      // Title Field
                      titleBox(),
                      // Description Field
                      descriptionBox(),
                      const SizedBox(height: 20),
                      // Location Picker
                      getLocation(title: "Custom location"),
                      const SizedBox(
                        height: 20,
                      ),
                      // getLocation(title: "Access restaurant location"),
                      // const SizedBox(height: 30),

                      // Upload Button
                      ButtonWidget(
                        ontap: () {
                          controller.uploadPost();
                        },
                        text: "UPLOAD POSTS",
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
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
            children: controller.selectedImages.map((image) {
              return Stack(
                children: [
                  Image.file(
                    image,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => controller.removeImage(image),
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
            controller: controller.descriptionController,
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

  InkWell getLocation({String title = "No caption?"}) {
    return InkWell(
        onTap: () async {
          final result = await Get.toNamed(Routes.getLoactionPage,
            arguments: controller.placeSelected,
          );
          if (result != null) {
            controller.placeSelected = result;
            controller.nameLocationDisplay.value =
                controller.placeSelected.displayName ?? "";
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.location_on_rounded,
                  color: AppColors.yellow,
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: Get.width * .7,
                  child: Obx(() {
                    return TextWidget(
                      text: controller.nameLocationDisplay.value.isNotEmpty
                          ? controller.nameLocationDisplay.value
                          : title,
                      fontWeight: FontWeight.w500,
                    );
                  }),
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.primary,
            )
          ],
        ));
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
