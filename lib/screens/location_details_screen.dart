import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/places_provider.dart';
import './map_screen.dart';

class LocationDetailsScreen extends StatelessWidget {
  static const routeName = 'detail-screen';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final selectedPlace =
        Provider.of<PlaceProvider>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [IconButton(icon: Icon(Icons.backspace_outlined), onPressed: (){
          Navigator.of(context).pop();
        })],
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              selectedPlace.image,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          Text(
            selectedPlace.location.address,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 10),
          FlatButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (_) => MapScreen(
                    initialLocation: selectedPlace.location,
                  ),
                ),
              );
            },
            icon: Icon(Icons.map),
            label: Text('View On Map'),
          ),
        ],
      ),
    );
  }
}
