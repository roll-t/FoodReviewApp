import 'package:find_food/core/configs/app_colors.dart';
import 'package:find_food/core/configs/app_dimens.dart';
import 'package:find_food/core/ui/widgets/card/posts_card/posts_card.dart';
import 'package:find_food/core/ui/widgets/text/text_widget.dart';
import 'package:find_food/features/find_post/result_search/presentation/controller/result_search_controller.dart';
import 'package:find_food/features/model/post_data_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResultSearchPage extends GetView<ResultSearchController> {
  const ResultSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: AppBar(
          leading: const Icon(Icons.search),
          title: const TextWidget(
            text: "Search",
            size: AppDimens.textSize26,
            fontWeight: FontWeight.w500,
          ),
          actions: [
            InkWell(
              onTap: () => Get.back(),
              child: Container(
                margin: const EdgeInsets.only(right: 20),
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                    color: AppColors.gray,
                    borderRadius: BorderRadius.circular(100)),
                child: const Icon(
                  Icons.close,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(left: 20, top: 20, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const TextWidget(
                      text: "search result: ",
                      fontWeight: FontWeight.w500,
                    ),
                    Flexible(
                      child: SizedBox(
                        width: 280,
                        child: Text(
                          controller.valueSearch,
                          maxLines: 1,
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),

      // Hiển thị  danh sách sản phẩm tìm kiếm
      body: GetBuilder<ResultSearchController>(
        id: "fetchPosts",
        builder: (logic) {
          return buildListPost();
        },
      ),
    );
  }

  Widget buildListPost() {
    return controller.listPost.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: controller.listPost.length,
            itemBuilder: (_, index) {
              PostDataModel postDataModel = controller.listPost[index];
              return PostsCard(
                postDataModel: postDataModel,
              );
            })
        : const SizedBox.shrink();
  }
}
