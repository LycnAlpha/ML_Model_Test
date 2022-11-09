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

  late File _image;
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
                height: 250,
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
                "Hi",
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
      var predictions = await Tflite.detectObjectOnImage(
          path: _imageFile.path, // required
          model: "YOLO",
          imageMean: 0.0,
          imageStd: 255.0,
          threshold: 0.3, // defaults to 0.1
          numResultsPerClass: 2, // defaults to 5
          anchors: [
            0.57273,
            0.677385,
            1.87446,
            2.06253,
            3.33843,
            5.47434,
            7.88282,
            3.52778,
            9.77052,
            9.16828
          ], // defaults to [0.57273,0.677385,1.87446,2.06253,3.33843,5.47434,7.88282,3.52778,9.77052,9.16828]
          blockSize: 32, // defaults to 32
          numBoxesPerBlock: 5, // defaults to 5
          asynch: true // defaults to true
          );
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
