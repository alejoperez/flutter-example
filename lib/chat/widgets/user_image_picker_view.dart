import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePickerView extends StatefulWidget {
  final void Function(File image) _setUserImage;

  UserImagePickerView(this._setUserImage);

  @override
  _UserImagePickerViewState createState() => _UserImagePickerViewState();
}

class _UserImagePickerViewState extends State<UserImagePickerView> {
  File _pickedImage;

  void _pickImage() async {
    final pickedImageFile = await ImagePicker.pickImage(source: ImageSource.camera, imageQuality: 50, maxWidth: 150);
    if(pickedImageFile != null) {
      setState(() {
        _pickedImage = pickedImageFile;
      });
      widget._setUserImage(_pickedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: _pickedImage != null ? FileImage(_pickedImage) : null,
        ),
        FlatButton.icon(
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: Text("Add image"),
          textColor: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}
