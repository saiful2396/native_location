import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelected;

  MapScreen({
    this.initialLocation = const PlaceLocation(
      latitude: 23.753,
      longitude: 90.379,
      // latitude: 37.422,
      // longitude: -122.084,
    ),
    this.isSelected = false,
  });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('You Map'),
        actions: [
          if (widget.isSelected)
            IconButton(
                icon: const Icon(Icons.check),
                onPressed: _pickedLocation == null
                    ? null
                    : () {
                        Navigator.of(context).pop(_pickedLocation);
                      }),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 13,
        ),
        onTap: widget.isSelected ? _selectLocation : null,
        markers: (_pickedLocation == null && widget.isSelected)
            ? null
            : {
                Marker(
                  markerId: MarkerId('m1'),
                  position: _pickedLocation ??
                      LatLng(
                        widget.initialLocation.latitude,
                        widget.initialLocation.longitude,
                      ),
                ),
              },
      ),
    );
  }
}
