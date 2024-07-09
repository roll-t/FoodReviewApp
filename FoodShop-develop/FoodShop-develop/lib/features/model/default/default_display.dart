

import 'package:find_food/core/configs/app_images_string.dart';
import 'package:find_food/features/model/post_data_model.dart';

class DefaultDisplay {
  
static  PostDataModel postsDefault=PostDataModel(
    title: "untitle",
    imageList: [AppImagesString.iPostsDefault],
    longitude: 0,
    latitude: 0,
    subtitle: "Un subtitle",
  );
}