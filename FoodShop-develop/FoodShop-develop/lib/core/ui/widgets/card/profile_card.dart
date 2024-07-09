import 'package:find_food/core/configs/app_colors.dart';
import 'package:find_food/core/configs/app_images_string.dart';
import 'package:find_food/core/extensions/helper.dart';
import 'package:find_food/features/model/post_data_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileCard extends StatelessWidget {
  final int favoriteCount;
  final String imageUrl;
  final bool isBookmarked;
  final bool isFavorited;
  final PostDataModel postDataModel;
  final GetxController controller;

  const ProfileCard(
      {super.key,
      this.favoriteCount = 0,
      this.imageUrl = AppImagesString.iPostsDefault,
      this.isBookmarked = false,
      this.isFavorited = false,
      required this.postDataModel,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: CustomShadow.cardShadow),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: postDataModel.imageList != null &&
                        postDataModel.imageList!.isNotEmpty
                    ? Image.network(
                        postDataModel.imageList!.first,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        imageUrl,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: Get.height * 0.5,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.black.withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(10)),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 15,
              child: Text(
                postDataModel.title ?? "",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: AppColors.white, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
