import 'package:flutter/material.dart';
import 'package:native_location/screens/location_details_screen.dart';
import 'package:provider/provider.dart';

import '../screens/add_location_screen.dart';
import '../provider/places_provider.dart';

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
        body: FutureBuilder(
            future: Provider.of<PlaceProvider>(context, listen: false)
                .fetchAndSetPlaces(),
            builder: (context, snapshot) => snapshot.connectionState ==
                    ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<PlaceProvider>(
                    child: Center(
                        child: const Text(
                            'Get no places yet, please add new places!')),
                    builder: (ctx, getPlace, ch) => getPlace.item.length <= 0
                        ? ch
                        : ListView.builder(
                            itemCount: getPlace.item.length,
                            itemBuilder: (ctx, i) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage: FileImage(
                                  getPlace.item[i].image,
                                ),
                              ),
                              title: Text(
                                getPlace.item[i].title,
                              ),
                              subtitle: Text(
                                getPlace.item[i].location.address,
                              ),
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  LocationDetailsScreen.routeName,
                                  arguments: getPlace.item[i].id,
                                );
                              },
                            ),
                          ),
                  )));
  }
}
