import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/place.dart';
import '../helper/db_helper.dart';

class PlaceProvider with ChangeNotifier {
  List<Place> _item = [];

  List<Place> get item => [..._item];

  void addPlace(String pickedTitle, File pickedImage) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: pickedTitle,
      image: pickedImage,
      location: null,
    );
    _item.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
    });
  }

  /*Future<void> fetchAndSetData() async {
    final dataList = await DBHelper.getData('user_places');
    _item = dataList
        .map(
          (element) => Place(
            id: element['id'],
            title: element['title'],
            location: null,
            image: File(element['image']),
          ),
        )
        .toList();
    notifyListeners();
  }*/
  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _item = dataList
        .map(
          (item) => Place(
        id: item['id'],
        title: item['title'],
        image: File(item['image']),
        location: null,
        /*location: PlaceLocation(
          latitude: item['loc_lat'],
          longitude: item['loc_lng'],
          address: item['address'],
        ),*/
      ),
    )
        .toList();
    notifyListeners();
  }
}
