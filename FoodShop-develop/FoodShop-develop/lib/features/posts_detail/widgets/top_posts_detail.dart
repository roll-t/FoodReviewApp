import 'package:find_food/core/configs/app_colors.dart';
import 'package:find_food/core/configs/app_constants.dart';
import 'package:find_food/core/configs/app_dimens.dart';
import 'package:find_food/core/configs/app_text_string.dart';
import 'package:find_food/core/extensions/helper.dart';
import 'package:find_food/core/routes/routes.dart';
import 'package:find_food/core/ui/dialogs/full_screen_image.dart';
import 'package:find_food/core/ui/widgets/avatar/avatar.dart';
import 'package:find_food/core/ui/widgets/icons/rating.dart';
import 'package:find_food/core/ui/widgets/text/text_widget.dart';
import 'package:find_food/features/model/post_data_model.dart';
import 'package:find_food/features/posts_detail/presentation/controller/posts_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

bool isVisible = true;

// ignore: must_be_immutable
class TopPostsDetail extends GetView<PostsDetailController> {
  const TopPostsDetail({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostsDetailController>(
        id: "fetchDataTopPostDetail",
        builder: (_) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _BuildHeaderPosts(controller: controller),
              SubTitle(controller: controller),
              Wrap(
                runSpacing: AppDimens.columnSpacing,
                children: [
                  _BuildSlider(controller: controller),
                  _BuildTagAddress(context),
                  TagInfoPosts(controller: controller),
                  if (controller.isRestaurant) const TagToRestauRant(),
                ],
              )
            ],
          );
        });
  }

  // ignore: non_constant_identifier_names
  Container _BuildTagAddress(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.spacing2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimens.radius1),
          boxShadow: CustomShadow.cardShadow,
          color: AppColors.white),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () async {
                if (controller.postDataModel?.placeMap != null &&
                    controller.postDataModel!.placeMap!['display_name'] !=
                        null &&
                    controller.postDataModel!.placeMap!['display_name'] !=
                        AppConstants.disPlayLoacionCurrent) {
                  await _BuildDialogShowLocation(context);
                }
              },
              child: Row(
                children: [
                  Column(
                    children: [
                      const Icon(Icons.location_on,
                          color: AppColors.red, size: AppDimens.textSize28),
                      const SizedBox(width: AppDimens.spacing1),
                      Text(
                        "${controller.distance} km",
                        style: const TextStyle(
                          fontSize: AppDimens.textSize10,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  controller.postDataModel?.placeMap != null &&
                          controller.postDataModel!.placeMap!['display_name'] !=
                              null &&
                          controller.postDataModel!.placeMap!['display_name'] !=
                              AppConstants.disPlayLoacionCurrent
                      ? _BuildDisplayLocation()
                      : const TextWidget(
                          text: "Accessing post locations on Maps",
                          size: AppDimens.textSize14,
                        )
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          InkWell(
              onTap: () async {
                if (controller.postDataModel?.placeMap != null &&
                    controller.postDataModel!.placeMap!['display_name'] !=
                        null) {
                  var result = await Get.toNamed(Routes.getLoactionPage,
                      arguments: {
                        "placeMap": controller.postDataModel?.placeMap
                      });
                  if (result != null) {}
                }
              },
              child: const Icon(
                Icons.arrow_forward_ios,
                color: AppColors.primary,
              ))
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Expanded _BuildDisplayLocation() {
    return Expanded(
        child: Text(
      controller.postDataModel?.placeMap != null
          ? controller.postDataModel!.placeMap!['display_name']
          : "Don't can access location",
      style: const TextStyle(fontSize: AppDimens.textSize14),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    ));
  }

  // ignore: non_constant_identifier_names
  Future<dynamic> _BuildDialogShowLocation(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Address Detail"),
            content: Text(
              controller.postDataModel?.placeMap != null
                  ? controller.postDataModel!.placeMap!['display_name']
                  : "Don't can access location",
              style: const TextStyle(fontSize: AppDimens.textSize14),
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
            ),
            actions: [
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                    ),
                    onPressed: () async {
                      if (controller.postDataModel?.placeMap != null) {
                        var result = await Get.toNamed(Routes.getLoactionPage,
                            arguments: {
                              "placeMap": controller.postDataModel?.placeMap
                            });
                        if (result != null) {
                          if (result['closeDialog'] == true) {
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pop();
                          }
                        }
                      }
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Location On Maps",
                          style: TextStyle(color: AppColors.white),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.white,
                          size: AppDimens.textSize18,
                        )
                      ],
                    )),
              )
            ],
          );
        });
  }
}

class _BuildHeaderPosts extends StatelessWidget {
  const _BuildHeaderPosts({
    super.key,
    required this.controller,
  });

  final PostsDetailController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: Get.width * .02),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 10),
          InkWell(
            onTap: () {
              Get.toNamed(Routes.profileClient,arguments: {"idAuthor":controller.authorPosts?.uid});
            },
            child: Avatar(
              authorImg: controller.authorPosts?.avatarUrl,
              radius: 50,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: Get.width * 0.6,
                      child: Text(
                        controller.postDataModel?.title?.trim() ??
                            AppTextString.fCardTitleDefault,
                        style: const TextStyle(
                            fontSize: AppDimens.textSize16,
                            fontWeight: FontWeight.w500),
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      _truncateText(
                          '${controller.timePosts} - ${controller.authorPosts?.displayName ?? controller.authorPosts?.email} '),
                      style: const TextStyle(
                        fontSize: AppDimens.textSize10,
                        fontWeight: FontWeight.w400,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                Obx(() {
                  return controller.userComment?.uid ==
                              controller.authorPosts?.uid &&
                          !controller.isLoading.value
                      ? const SizedBox()
                      : IconButton(
                          onPressed: () async {
                            if (controller.isProcessing) return;
                            await controller.toggleBookmarkState(
                                stateIcon: controller.isBookmark.value);
                          },
                          icon: Icon(
                            controller.isBookmark.value
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            color: controller.isBookmark.value
                                ? Colors.yellow
                                : null,
                          ),
                        );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SubTitle extends StatelessWidget {
  const SubTitle({
    super.key,
    required this.controller,
  });

  final PostsDetailController controller;

  @override
  Widget build(BuildContext context) {
    final subtitle = controller.postDataModel?.subtitle?.trim() ??
        AppTextString.fCardDesription;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SubtitleText(subtitle: subtitle),
    );
  }
}

class SubtitleText extends StatelessWidget {
  const SubtitleText({super.key, required this.subtitle});

  final String subtitle;
  final int trimLength = 100;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isExpanded = ValueNotifier<bool>(false);

    return ValueListenableBuilder<bool>(
      valueListenable: isExpanded,
      builder: (context, value, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              subtitle,
              maxLines: value ? null : 2,
            ),
            if (subtitle.trim().length > trimLength)
              TextButton(
                onPressed: () {
                  isExpanded.value = !isExpanded.value;
                },
                child: Text(
                  value ? 'Collapse' : 'See more',
                  style: const TextStyle(
                    fontSize: AppDimens.textSize10,
                    color: AppColors.red,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class TagToRestauRant extends StatelessWidget {
  const TagToRestauRant({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.width,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppDimens.radius1),
          boxShadow: CustomShadow.cardShadow,
        ),
        child: Column(
          children: [
            isVisible
                ? const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Restaurant Name',
                        style: TextStyle(
                            fontSize: AppDimens.textSize14,
                            color: AppColors.black),
                      ),
                      // SizedBox(width: 120),
                      Spacer(),
                      Row(
                        children: [
                          Text(
                            'To restaurant',
                            style: TextStyle(
                              fontSize: AppDimens.textSize14,
                              color: AppColors.red,
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: AppColors.red,
                          )
                        ],
                      ),
                    ],
                  )
                : Container(), // Or SizedBox.shrink() if you prefer
          ],
        ));
  }
}

class TagInfoPosts extends StatelessWidget {
  const TagInfoPosts({
    super.key,
    required this.controller,
  });
  final PostsDetailController controller;
  @override
  Widget build(BuildContext context) {
    double reat = 4;
    int reatPerson = 20;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: CustomShadow.cardShadow),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  controller.postDataModel?.restaurantId != ""
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Text(
                                "$reat",
                                style: const TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Row(
                                  children: [
                                    ...Rating.RenderStar(
                                        star: reat, sizeStar: 25)
                                  ],
                                ),
                              ),
                              Text(
                                "($reatPerson)",
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(
                          height: 0,
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (controller.isRestaurant)
                        const Text(
                          "Opening",
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.green,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        const Icon(Icons.comment,
                            color: AppColors.gray, size: AppDimens.textSize20),
                        TextWidget(
                            text: '${controller.listComments.length ?? 0}',
                            size: AppDimens.textSize15),
                      ],
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    GetBuilder<PostsDetailController>(
                      id: controller.postDataModel?.id,
                      builder: (_) {
                        bool isFavorited = controller.isFavorite.value;
                        return InkWell(
                          excludeFromSemantics: true,
                          onTap: () async {
                            if (controller.isProcessing) return;
                            await controller.toggleFavoriteState(
                                posts:
                                    controller.postDataModel ?? PostDataModel(),
                                stateIcon: !isFavorited);
                            controller
                                .update([controller.postDataModel?.id ?? ""]);
                          },
                          child: Column(
                            children: [
                              Icon(
                                isFavorited
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFavorited ? AppColors.red : null,
                                size: AppDimens.textSize20,
                              ),
                              FutureBuilder<int>(
                                future: controller.getCountFavorite(
                                    controller.postDataModel!.id ?? ""),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const SizedBox(
                                        width: AppDimens.textSize12,
                                        height: AppDimens.textSize20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 1,
                                        ));
                                  } else if (snapshot.hasError) {
                                    return const TextWidget(
                                      text: '0',
                                      size: AppDimens.textSize15,
                                    );
                                  } else {
                                    return TextWidget(
                                      text: '${snapshot.data}',
                                      size: AppDimens.textSize15,
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BuildSlider extends StatelessWidget {
  const _BuildSlider({
    super.key,
    required this.controller,
  });

  final PostsDetailController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * .35,
      child: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(AppDimens.radius1),
                        boxShadow: CustomShadow.cardShadow),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppDimens.radius1),
                      child: Column(
                        children: [
                          MainImageSlide(),
                          listImaegs_BuildSlider(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: Get.height * .1,
            child: ButtonCotrolSlide(),
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Expanded MainImageSlide() {
    return Expanded(
      flex: 2,
      child: PageView.builder(
        controller: controller.mainPageController,
        itemCount: controller.listImagesPostDetail.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.to(() => FullScreenImage(
                    initialIndex: index,
                    controller: controller,
                  ));
            },
            child: Image.network(
              controller.listImagesPostDetail[index],
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Row ButtonCotrolSlide() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: controller.previousImage,
            icon: const Icon(Icons.chevron_left, size: 30, color: Colors.grey),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: controller.nextImage,
            icon: const Icon(Icons.chevron_right, size: 30, color: Colors.grey),
          ),
        ),
      ],
    );
  }

  Expanded listImaegs_BuildSlider() {
    return Expanded(
      flex: 1,
      child: controller.listImagesPostDetail.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(5),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 5,
                ),
                itemCount: controller.listImagesPostDetail.length > 4
                    ? 4
                    : controller.listImagesPostDetail.length,
                itemBuilder: (context, index) {
                  if (index == 3 &&
                      controller.listImagesPostDetail.length > 4) {
                    return GestureDetector(
                      onTap: controller.showMoreImages,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(AppDimens.radius1),
                            child: Image.network(
                              controller.listImagesPostDetail[index],
                              fit: BoxFit.cover,
                              color: Colors.grey.withOpacity(0.6),
                              colorBlendMode: BlendMode.darken,
                            ),
                          ),
                          Center(
                            child: Text(
                              '+${controller.listImagesPostDetail.length - 3}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => FullScreenImage(
                              initialIndex: index,
                              controller: controller,
                            ));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppDimens.radius1),
                        child: Image.network(
                          controller.listImagesPostDetail[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }
                },
              ),
            )
          : Container(),
    );
  }
}

String _truncateText(
  String text,
) {
  const maxLength = 30; // Độ dài tối đa của chuỗi
  return text.length > maxLength ? '${text.substring(0, maxLength)}...' : text;
}