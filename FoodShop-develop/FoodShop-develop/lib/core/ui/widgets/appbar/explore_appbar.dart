import 'package:find_food/core/configs/app_colors.dart';
import 'package:find_food/core/configs/app_dimens.dart';
import 'package:find_food/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
    
// ignore: must_be_immutable
class ExploreAppbar extends StatelessWidget  implements PreferredSizeWidget {

  const ExploreAppbar({ super.key});
  
  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    void handleSearch(String value){
      Get.toNamed(Routes.resultSearch,arguments: value);
    } 

    return PreferredSize(
        preferredSize: const Size.fromHeight(115),
        child: AppBar(
          backgroundColor: AppColors.white,
          flexibleSpace: Container(
            padding: EdgeInsets.all(Get.width*0.03),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Search',
                  style: TextStyle(
                      fontSize: AppDimens.textSize26,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.gray2,
                    border: Border.all(
                      color: AppColors.gray.withOpacity(.1),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextField(
                    controller: controller,
                    onSubmitted: handleSearch,
                    textInputAction: TextInputAction.done, 
                    decoration: const InputDecoration(
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w400, color: AppColors.grey),
                        hintText: "Search on foodly",
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 15)),
                  ),
                )
              ],
            ),
          ),
        ),
      );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 60);
}