import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widget/image_input.dart';
import '../widget/location_input.dart';
import '../provider/places_provider.dart';
import '../models/place.dart';

class AddLocationScreen extends StatefulWidget {
  static const routeName = 'add-location';

  @override
  _AddLocationScreenState createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  final _titleController = TextEditingController();
  File _pickedImage;
  PlaceLocation _pickedLocation;

  void _selectPLace(double lat, double lng) {
    _pickedLocation = PlaceLocation(
      latitude: lat,
      longitude: lng,
    );
  }

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _saveImage() {
    if (_titleController.text.isEmpty ||
        _pickedImage == null ||
        _pickedLocation == null) {
      return;
    }
    Provider.of<PlaceProvider>(context, listen: false).addPlace(
      _titleController.text,
      _pickedImage,
      _pickedLocation,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Your Location'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                    ),
                    SizedBox(height: 10),
                    ImageInput(_selectImage),
                    SizedBox(height: 10),
                    LocationInput(_selectPLace),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            icon: Icon(Icons.add),
            label: Text('Add Location'),
            color: Theme.of(context).accentColor,
            textColor: Colors.white,
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: _saveImage,
          ),
        ],
      ),
    );
  }
}
