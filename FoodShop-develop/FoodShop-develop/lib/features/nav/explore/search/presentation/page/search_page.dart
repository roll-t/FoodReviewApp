import 'package:find_food/core/configs/app_colors.dart';
import 'package:find_food/core/configs/app_dimens.dart';
import 'package:find_food/core/configs/app_images_string.dart';
import 'package:find_food/core/configs/app_text_string.dart';
import 'package:find_food/core/routes/routes.dart';
import 'package:find_food/core/ui/widgets/appbar/explore_appbar.dart';
import 'package:find_food/core/ui/widgets/card/explore_food_card.dart';
import 'package:find_food/core/ui/widgets/card/posts_card/posts_card.dart';
import 'package:find_food/core/ui/widgets/loading/loading_data_page.dart';
import 'package:find_food/core/ui/widgets/text/text_widget.dart';
import 'package:find_food/features/nav/explore/search/presentation/controller/search_controller.dart';
import 'package:find_food/features/model/post_data_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPage extends GetView<ExploreController> {
  const SearchPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const ExploreAppbar(),
        body: GetBuilder<ExploreController>(
          id: "fetchDataExplorepage",
          builder: (_) {
            return RefreshIndicator(
                onRefresh: () async {
                  await controller.refreshPage();
                },
                child: _buildListPostStream());
          },
        ));
  }

  _buildListPostStream() {
    return controller.isLoading.value
        ? const LoadingDataPage()
        : SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GetBuilder<ExploreController>(
                  builder: (_) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildBodyListExplore(
                            title: 'Area', dataPosts: controller.listPostArea),
                        _buildBodyListExplore(
                            title: 'Favorite',
                            dataPosts: controller.listPostFavorite),
                        _buildBodyListPosts(
                            title: "Relate", dataPosts: controller.listPost),
                      ],
                    );
                  },
                )),
          );
  }

  Column _buildBodyListPosts(
      {String title = "untitle", List<PostDataModel> dataPosts = const []}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: title,
          size: AppDimens.textSize22,
          fontWeight: FontWeight.w500,
        ),
        const SizedBox(
          height: 10,
        ),
        dataPosts.isNotEmpty
            ? ListView.builder(
                physics:
                    const NeverScrollableScrollPhysics(), // Disable scrolling
                shrinkWrap: true,
                itemCount: dataPosts.length,
                itemBuilder: (_, index) {
                  PostDataModel postDataModel = dataPosts[index];
                  return PostsCard(
                    postDataModel: postDataModel,
                  );
                })
            : const SizedBox.shrink()
      ],
    );
  }

  Column _buildBodyListExplore(
      {String title = "Untitle", List<PostDataModel> dataPosts = const []}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: title,
          size: AppDimens.textSize20,
          fontWeight: FontWeight.w500,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: dataPosts.isEmpty
              ? const SizedBox.shrink()
              : Row(
                  children: dataPosts.map((postDataModel) {
                    var imageUrl = postDataModel.imageList?.first;
                    var title = postDataModel.title;
                    return Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: ExploreFoodCard(
                        imageUrl: imageUrl ?? AppImagesString.iCardDefault,
                        title: title ?? AppTextString.fCardTitleDefault,
                        rating: 2.5,
                        customerRating: 10,
                        distance: 2.1,
                        postDataModel: postDataModel,
                      ),
                    );
                  }).toList(),
                ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: InkWell(
            onTap: () => {
              Get.toNamed(Routes.categorySearch),
            },
            child: dataPosts.length > 3
                ? const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "See more",
                        style: TextStyle(color: AppColors.gray),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: AppDimens.textSize14,
                      )
                    ],
                  )
                : const SizedBox(),
          ),
        )
      ],
    );
  }
}
