import 'package:find_food/core/ui/widgets/card/explore_food_card.dart';
import 'package:find_food/features/find_post/category/presentation/controller/category_controller.dart';
import 'package:find_food/features/model/post_data_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteCategoryPage extends GetView<CategoryController> {
  const FavoriteCategoryPage({super.key});


  @override
  Widget build(BuildContext context) {
     return Obx(() {
      if (controller.areaPosts.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width*0.035),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: controller.areaPosts.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              mainAxisSpacing:Get.width*0.07,
              crossAxisSpacing:Get.width*0.07,
            ),
            itemBuilder: (_, index) {
              PostDataModel postDataModel =
                  PostDataModel.fromDocumentSnapshot(controller.areaPosts[index]);
              return ExploreFoodCard(
                title: postDataModel.title ?? "",
                imageUrl: postDataModel.imageList!.first,
                rating: 3,
                customerRating: 30,
                distance: 2, postDataModel: postDataModel,
              );
            },
          ),
        );
      }
    });
  }

}