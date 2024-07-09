import 'dart:convert';

import 'package:find_food/core/configs/prefs_constants.dart';
import 'package:find_food/core/data/prefs/prefs.dart';
import 'package:find_food/features/auth/user/model/user_model.dart';

class GetuserUseCase {
  final Prefs _prefs;

  GetuserUseCase(this._prefs);

  Future<UserModel?> getUser() async {
    final tokenJson = await _prefs.getObject(PrefsConstants.user);
    if (tokenJson.isEmpty) {
      return null;
    }
    return UserModel.fromJson(json.decode(tokenJson));
  }
}
