import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as paths;
import 'package:path_provider/path_provider.dart' as sysPaths;

class ImageInput extends StatefulWidget {
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storeImage;
  final _picker = ImagePicker();

  Future<void> _takeImage() async {
    final imageFile = await _picker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    setState(() {
      if (imageFile != null) {
        _storeImage = File(imageFile.path);
      } else {
        print('No image selected.');
      }
    });
    final appDir = await sysPaths.getApplicationDocumentsDirectory();
    final fileName = paths.basename(imageFile.path);
    final savedImage = '${appDir.path}/$fileName';
  }

  Future<void> retrieveLostData() async {
    final LostData response =
    await _picker.getLostData();
    if (response.isEmpty) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Container(
            height: 100,
            width: 150,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
            ),
            child: _storeImage != null
                ? Image.file(
                    _storeImage,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )
                : Text(
                    'No Image Selected',
                    textAlign: TextAlign.center,
                  ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: FlatButton.icon(
              onPressed: _takeImage,
              icon: Icon(Icons.camera_alt_outlined),
              textColor: Theme.of(context).primaryColor,
              label: Text('Take Picture'),
            ),
          ),
        ],
      ),
    );
  }
}
