import 'package:find_food/core/configs/prefs_constants.dart';
import 'package:find_food/core/data/prefs/prefs.dart';
import 'package:find_food/features/maps/location/models/place_map.dart';

class SaveLoactionCase {
  final Prefs _prefs;

  SaveLoactionCase(this._prefs);
  Future saveLocation(PlaceMap placeMap) async {
    _prefs.set(PrefsConstants.location, placeMap);
  }
}
