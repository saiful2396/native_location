import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../helper/location_helper.dart';
import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectLocation;

  LocationInput(this.onSelectLocation);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  void _showPreview(double lat, double lng) {
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
      latitude: lat,
      longitude: lng,
    );
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _getUserCurrentLocation() async {
    try {
      final locData = await Location().getLocation();
      _showPreview(
        locData.latitude,
        locData.longitude,
      );
      widget.onSelectLocation(
        locData.latitude,
        locData.longitude,
      );
    } catch (error) {
      return;
    }
  }

  Future<void> _selectMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => MapScreen(
          isSelected: true,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    _showPreview(
      selectedLocation.latitude,
      selectedLocation.longitude,
    );
    widget.onSelectLocation(
      selectedLocation.latitude,
      selectedLocation.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _previewImageUrl == null
              ? const Text(
                  'No Location chosen!',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(
              onPressed: _getUserCurrentLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Current location'),
              textColor: Theme.of(context).primaryColor,
            ),
            FlatButton.icon(
              onPressed: _selectMap,
              icon: const Icon(Icons.map),
              label: const Text('Select on Map'),
              textColor: Theme.of(context).primaryColor,
            ),
          ],
        )
      ],
    );
  }
}
