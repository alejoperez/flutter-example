import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sysPaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _takePicture() async {
    final imageFile = await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if(imageFile != null) {
      setState(() {
        _storedImage = imageFile;
      });

      final appDirectory = await sysPaths.getApplicationDocumentsDirectory();
      final fileName = path.basename(imageFile.path);
      final savedImage = await imageFile.copy("${appDirectory.path}/$fileName");
      widget.onSelectImage(savedImage);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 100,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _storedImage != null
              ? Image.file(_storedImage,
                  fit: BoxFit.cover, width: double.infinity)
              : Text("No Image taken", textAlign: TextAlign.center,),
          alignment: Alignment.center,
        ),
        SizedBox(width: 10),
        Expanded(
            child: FlatButton.icon(
          textColor: Theme.of(context).primaryColor,
          icon: Icon(Icons.camera),
          label: Text("Take Picture"),
          onPressed: _takePicture,
        ))
      ],
    );
  }
}
