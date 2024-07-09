import 'package:find_food/core/configs/app_colors.dart';
import 'package:find_food/core/configs/app_dimens.dart';
import 'package:find_food/core/configs/app_text_string.dart';
import 'package:flutter/material.dart';
    
class UploadPostAppbar extends StatelessWidget implements PreferredSizeWidget  {

  const UploadPostAppbar({ super.key });
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: const Text(
          AppTextString.fUploadAppbar,
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: AppDimens.textSize22),
        ),
        centerTitle: true, // Center the title
        toolbarHeight: 50,
        
        bottom: PreferredSize(
          preferredSize:
              const Size.fromHeight(2.0), // Adjust the height of the bottom border
          child: Container(
            color: AppColors.primary, // Border color
            height: 2, // Border height
          ),
        ),
      );
  }

  
  @override
  Size get preferredSize => AppBar().preferredSize;
}