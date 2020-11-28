import 'dart:convert';

import 'package:http/http.dart';

const GOOGLE_API_KEY = 'AIzaSyDnIZj5SxU8Zo87f54s0gLS7bSLt9me3X4';

class LocationHelper {
  static String generateLocationPreviewImage({
    double latitude,
    double longitude,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:S%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY';
    final response = await get(url);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
