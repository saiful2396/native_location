import 'package:flutter/material.dart';

import '../widget/image_input.dart';

class AddLocationScreen extends StatefulWidget {
  static const routeName = 'add-location';

  @override
  _AddLocationScreenState createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  final _titleController = TextEditingController();
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
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                    ),
                  ),
                  SizedBox(height: 10),
                  ImageInput(),
                ],
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
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
