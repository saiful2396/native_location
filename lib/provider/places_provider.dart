import 'package:flutter/foundation.dart';

import '../models/place.dart';

class PlaceProvider with ChangeNotifier {
  List<Place> _item = [];

  List<Place> get item => [..._item];
}