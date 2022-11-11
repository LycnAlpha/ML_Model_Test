import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mltest/widgets/roundedButton.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:tflite/tflite.dart';

import 'homePage.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  String output = "";
  late PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();

  File? _image;
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text('Upload & Convert'),
            backgroundColor: Colors.blue,
            automaticallyImplyLeading: false,
            leading: new IconButton(
                onPressed: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => HomePage())),
                icon: new Icon(Icons.arrow_back, color: Colors.black)),
          ),
          body: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Container(
                child: _image != null
                    ? Image.file(_image!)
                    : Text("No image selected"),
              ),
              SizedBox(
                height: 30,
              ),
              RoundedButton(
                  buttonName: "Upload",
                  onPressed: () {
                    takePhoto(ImageSource.gallery);
                  }),
              SizedBox(
                height: 50,
              ),
              RoundedButton(
                  buttonName: "Detect",
                  onPressed: () {
                    loadModel();
                    runModel();
                  }),
              SizedBox(
                height: 50,
              ),
              Text(
                output,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )
            ],
          ),
        ),
      ],
    );
  }

  loadModel() async {
    await Tflite.loadModel(
        model: "assets/model2.tflite", labels: "assets/labels.txt");
  }

  runModel() async {
    if (_imageFile != null) {
      var predictions = await Tflite.runModelOnImage(
          path: _imageFile.path,
          imageMean: 0.0, // defaults to 117.0
          imageStd: 255.0, // defaults to 1.0
          numResults: 2, // defaults to 5
          threshold: 0.2, // defaults to 0.1
          asynch: true);

      predictions!.forEach((element) {
        setState(() {
          output = element['label'];
        });
      });

      print(output);
    }
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _imageFile = pickedFile;
        print('Image selected.');
        print(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
}
