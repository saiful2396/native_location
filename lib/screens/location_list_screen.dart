import 'package:flutter/material.dart';

import '../screens/add_location_screen.dart';

class LocationListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Location'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddLocationScreen.routeName);
            },
          ),
        ],
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
