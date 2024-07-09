import 'dart:convert';

import 'package:find_food/core/configs/prefs_constants.dart';
import 'package:find_food/core/data/prefs/prefs.dart';
import 'package:get/get.dart';

class FavoriteService extends GetxService {
  final Prefs prefs;

  FavoriteService(this.prefs);

  void saveFavoriteCase() {
    List<String> listPostFavorite = ["id1", "id2", "id3"];
    try {
      var result = prefs.get(PrefsConstants.favorite);
      print(result);
    } catch (e) {
      prefs.set(PrefsConstants.favorite, jsonEncode(listPostFavorite));
    }
  }
}
