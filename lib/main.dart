import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/location_list_screen.dart';
import './screens/add_location_screen.dart';
import './provider/places_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: PlaceProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Location App Use Google Maps',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        home: LocationListScreen(),
        routes: {
          AddLocationScreen.routeName:(_) => AddLocationScreen(),
        },
      ),
    );
  }
}
