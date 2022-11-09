import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mltest/main.dart';
import 'package:tflite/tflite.dart';

import 'homePage.dart';

class LetsTalk extends StatefulWidget {
  const LetsTalk({Key? key}) : super(key: key);

  @override
  State<LetsTalk> createState() => _LetsTalkState();
}

class _LetsTalkState extends State<LetsTalk> {
  CameraImage? cameraImage;
  CameraController? cameraController;
  String output = "";
  int _imageCount = 0;

  @override
  void initState() {
    super.initState();
    loadModel();
    loadCamera();
  }

  loadCamera() {
    cameraController = CameraController(cameras![0], ResolutionPreset.medium);
    cameraController!.initialize().then((value) {
      if (!mounted) {
        return;
      } else {
        setState(() {
          cameraController!.startImageStream((ImageStream) async {
            cameraImage = ImageStream;
            _imageCount++;
            if (_imageCount % 50 == 0) {
              _imageCount = 0;
              runModel();
            }

            //await Tflite.close();
          });
        });
      }
    });
  }

  runModel() async {
    if (cameraImage != null) {
      var predictions = await Tflite.runModelOnFrame(
        bytesList: cameraImage!.planes.map((Plane) {
          return Plane.bytes;
        }).toList(),
        imageHeight: cameraImage!.height,
        imageWidth: cameraImage!.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 2,
        threshold: 0.1,
        asynch: true,
      );

      predictions!.forEach((element) {
        setState(() {
          output = element['label'];
        });
      });
    }
  }

  loadModel() async {
    await Tflite.loadModel(
        model: "assets/model2.tflite", labels: "assets/labels.txt");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Let's Talk"),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        leading: new IconButton(
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomePage())),
            icon: new Icon(Icons.arrow_back, color: Colors.black)),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              child: !cameraController!.value.isInitialized
                  ? Container()
                  : AspectRatio(
                      aspectRatio: cameraController!.value.aspectRatio,
                      child: CameraPreview(cameraController!),
                    ),
            ),
          ),
          Text(
            output,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          )
        ],
      ),
    );
  }
}
