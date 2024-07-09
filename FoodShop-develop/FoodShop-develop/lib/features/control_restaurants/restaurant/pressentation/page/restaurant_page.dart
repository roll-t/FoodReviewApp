import 'package:find_food/core/configs/app_colors.dart';
import 'package:find_food/core/configs/app_dimens.dart';
import 'package:find_food/core/configs/app_images_string.dart';
import 'package:find_food/core/extensions/helper.dart';
import 'package:find_food/core/ui/widgets/appbar/restaurant_appbar.dart';
import 'package:find_food/core/ui/widgets/avatar/avatar.dart';
import 'package:find_food/core/ui/widgets/loading/loading_data_page.dart';
import 'package:find_food/core/ui/widgets/text/text_widget.dart';
import 'package:find_food/features/control_restaurants/restaurant/pressentation/controller/restaurant_controller.dart';
import 'package:find_food/features/control_restaurants/restaurant/pressentation/widgets/card_menu_restaurant.dart';
import 'package:find_food/features/control_restaurants/restaurant/pressentation/widgets/icon_button.dart';
import 'package:find_food/features/control_restaurants/restaurant/pressentation/widgets/item_infor_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestaurantPage extends GetView<RestaurantController> {
  const RestaurantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RestaurantAppbar(),
      body: RefreshIndicator(onRefresh: () async {
        await controller.refreshPage();
      }, child: Obx(() {
        return controller.isLoading.value
            ? const LoadingDataPage()
            : buildBody();
      })),
    );
  }

  Widget buildBody() {
    double freebase = 50;
    double bannerSize = 300.0;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: bannerSize + freebase,
            child: Stack(
              children: [
                getWallpapper(bannerSize: bannerSize),
                iconButtonEditBackground(),
                Positioned(
                  bottom: 0 + freebase,
                  right: 0,
                  width: Get.width * 0.88,
                  child: inforRestaurant(),
                ),
                Positioned(
                  bottom: -(Get.width * .12) + freebase,
                  left: Get.width * .04,
                  child: getAvatar(),
                ),
                Positioned(bottom: 0, right: 0, child: ratingRestaurant())
              ],
            ),
          ),
          const SizedBox(
              height:
                  AppDimens.spacing5), // Add space to accommodate the rating
          buildInfoSection(),
          const SizedBox(height: AppDimens.spacing3),
          buildContactSection(),
          const SizedBox(height: AppDimens.spacing3),
          buildAddressSection(),
          const SizedBox(height: AppDimens.spacing6),
          buildMenuSection(),
          const SizedBox(height: AppDimens.spacing2),
          // buildGridOrders(), const SizedBox(height: AppDimens.spacing3),
          // CommentsRestaurants(), // Ensure this is correctly implemented and visible
        ],
      ),
    );
  }

  Widget buildInfoSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppDimens.radius1),
          boxShadow: CustomShadow.cardShadow),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: ItemInforProfile(quantity: 130, title: "Reviews "),
          ),
          Flexible(
            child: ItemInforProfile(quantity: 130, title: "Post "),
          ),
          Flexible(
            child: ItemInforProfile(quantity: 130, title: "Saved"),
          ),
          Flexible(
            child: ItemInforProfile(quantity: 130, title: "Liked"),
          ),
        ],
      ),
    );
  }

  Widget buildContactSection() {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppDimens.radius1),
          boxShadow: CustomShadow.cardShadow),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextWidget(
                text: "OPENING",
                fontWeight: FontWeight.bold,
                size: AppDimens.textSize18,
              ),
              TextWidget(text: "7:00 - 23:00", size: AppDimens.textSize18)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.phone,
                color: AppColors.black,
                size: 25,
              ),
              TextWidget(
                text: "Contact",
                color: AppColors.primary,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buildAddressSection() {
    return GetBuilder<RestaurantController>(
        id: "getInforRestaurant",
        builder: (controller) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppDimens.radius1),
                boxShadow: CustomShadow.cardShadow),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.location_on,
                      size: 30,
                      color: Colors.red,
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: TextWidget(
                      text: controller.addressRestaurant,
                      size: AppDimens.textSize18,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget buildMenuSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const TextWidget(
            text: "Menu",
            color: AppColors.red,
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed('createmenu');
            },
            child: const Row(
              children: [
                TextWidget(text: "Add Food"),
                SizedBox(width: 5),
                Image(
                  image: AssetImage('assets/icons/ic_add_foodmenu.png'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getWallpapper({required double bannerSize}) {
    return GetBuilder<RestaurantController>(
      id: "getInforRestaurant",
      builder: (controller) {
        return Container(
          height: bannerSize,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: controller.backgroundUrl != null &&
                      controller.backgroundUrl!.isNotEmpty
                  ? NetworkImage(controller.backgroundUrl!)
                  : const AssetImage(AppImagesString.iBackgroundUserDefault)
                      as ImageProvider,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }

  Widget getAvatar() {
    return GetBuilder<RestaurantController>(
      id: "getInforRestaurant",
      builder: (controller) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Avatar(
              radius: 145,
              authorImg: controller.avatarUrl,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: iconButton(
                icon: Icons.edit,
                onPressed: () {
                  controller.selectImageAvatarGallery();
                },
              ),
            )
          ],
        );
      },
    );
  }

  Widget ratingRestaurant() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextWidget(
          text: "5.0",
          size: AppDimens.textSize32,
        ),
        SizedBox(width: 5.0),
        Row(
          children: [
            Icon(Icons.star, color: Colors.amber, size: AppDimens.textSize26),
            Icon(Icons.star, color: Colors.amber, size: AppDimens.textSize26),
            Icon(Icons.star, color: Colors.amber, size: AppDimens.textSize26),
            Icon(Icons.star, color: Colors.amber, size: AppDimens.textSize26),
            Icon(Icons.star, color: Colors.amber, size: AppDimens.textSize26),
          ],
        ),
        SizedBox(width: 5.0),
        TextWidget(
          text: "(300)",
          size: AppDimens.textSize14,
        ),
        SizedBox(width: 15.0),
      ],
    );
  }

  Widget iconButtonEditBackground() {
    return Positioned(
      top: 20,
      right: 10,
      child: iconButton(
        icon: Icons.edit,
        onPressed: () {
          controller.selectImageWallpaper();
        },
      ),
    );
  }

  Widget inforRestaurant() {
    return GetBuilder<RestaurantController>(
        id: "getInforRestaurant",
        builder: (controller) {
          return Container(
            padding: EdgeInsets.only(
                left: Get.width * .35, bottom: 10, right: AppDimens.spacing3),
            color: Colors.white.withOpacity(0.7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: controller.nameRestaurant,
                  fontWeight: FontWeight.w700,
                  size: AppDimens.textSize22,
                  color: AppColors.primary,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            size: AppDimens.textSize9,
                            text: "Email: ${controller.emailRestaurant}",
                          ),
                          TextWidget(
                            size: AppDimens.textSize9,
                            text: "SDT: ${controller.phoneRestaurant}",
                          ),
                        ],
                      ),
                    ),
                    const Row(
                      children: [
                        Icon(
                          Icons.facebook,
                          size: AppDimens.textSize10,
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.facebook,
                          size: AppDimens.textSize10,
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.facebook,
                          size: AppDimens.textSize10,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  // Widget buildGridOrders() {
  //   return Obx(() {
  //     return GridView.builder(
  //       shrinkWrap: true,
  //       physics: const NeverScrollableScrollPhysics(),
  //       padding: const EdgeInsets.symmetric(horizontal: 20),
  //       itemCount: controller.itemsToShow.value <= controller.menu.length
  //           ? controller.itemsToShow.value + 1
  //           : controller.itemsToShow.value,
  //       itemBuilder: (BuildContext context, int index) {
  //         if (index == controller.itemsToShow.value) {
  //           return GestureDetector(
  //             onTap: controller.seeMore,
  //             child: const Padding(
  //               padding: EdgeInsets.symmetric(horizontal: 10),
  //               child: TextWidget(
  //                 textAlign: TextAlign.start,
  //                 text: "See More",
  //                 color: AppColors.blue,
  //                 size: AppDimens.textSize18,
  //               ),
  //             ),
  //           );
  //         } else {
  //           final foodMenu = controller.menu[index];
  //           return GestureDetector(
  //             onTap: () {
  //               controller.inforCard(foodMenu);
  //               showModalBottomSheet(
  //                 context: context,
  //                 isScrollControlled: true,
  //                 shape: const RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.vertical(
  //                     top: Radius.circular(20),
  //                   ),
  //                 ),
  //                 builder: (BuildContext context) {
  //                   return Padding(
  //                     padding: EdgeInsets.only(
  //                       bottom: MediaQuery.of(context).viewInsets.bottom,
  //                     ),
  //                     child: ListView(
  //                       shrinkWrap: true,
  //                       children: [
  //                         Center(
  //                           child: Container(
  //                             padding: const EdgeInsets.all(16.0),
  //                             child:
  //                                 EditFoodModal(food: foodMenu, index: index),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   );
  //                 },
  //               );
  //             },
  //             child: CardMenuRestaurant(
  //               img: foodMenu.imageFood,
  //               foodname: foodMenu.foodName,
  //               pricefood: foodMenu.priceFood,
  //             ),
  //           );
  //         }
  //       },
  //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //         crossAxisCount: 2,
  //         crossAxisSpacing: 4.0,
  //         mainAxisSpacing: 4.0,
  //       ),
  //     );
  //   });
  // }
}
