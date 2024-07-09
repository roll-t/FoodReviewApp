import 'package:find_food/core/configs/prefs_constants.dart';
import 'package:find_food/core/data/prefs/prefs.dart';
import 'package:find_food/features/auth/user/model/user_model.dart';

class SaveUserUseCase {
  final Prefs _prefs;

  SaveUserUseCase(this._prefs);

  Future saveUser(UserModel user) async {
    _prefs.set(PrefsConstants.user, user);
  }
}
