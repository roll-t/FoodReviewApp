import 'dart:convert';

import 'package:find_food/core/configs/prefs_constants.dart';
import 'package:find_food/core/data/prefs/prefs.dart';
import 'package:find_food/features/maps/location/models/place_map.dart';

class GetLocationCase {
  final Prefs _prefs;

  GetLocationCase(this._prefs);

  Future<PlaceMap?> getLocation() async {
    final tokenJson = await _prefs.getObject(PrefsConstants.location);
    if (tokenJson.isEmpty) {
      return null;
    }
    
    return PlaceMap.fromJson(json.decode(tokenJson));
  }
  
}
