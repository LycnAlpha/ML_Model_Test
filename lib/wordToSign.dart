import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mltest/widgets/roundedButton.dart';
import 'package:mltest/widgets/textInputField.dart';
import 'package:tflite/tflite.dart';

import 'homePage.dart';

class WordtoSign extends StatefulWidget {
  const WordtoSign({Key? key}) : super(key: key);

  @override
  State<WordtoSign> createState() => _WordtoSignState();
}

class _WordtoSignState extends State<WordtoSign> {
  String msg = " ";
  final TextEditingController _controller = TextEditingController();
  Future loadModel() async {
    Tflite.close();
    try {
      String res;
      res = (await Tflite.loadModel(
          model: "assets/models/converted_model.tflite"))!;
      print(res);
    } on PlatformException {
      print("Failed to load model");
    }
  }

  File? _image;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text('Word to Sign'),
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
                child: msg != " "
                    ? Image.asset(msg)
                    : Image.asset("assets/user.png"),
              ),
              SizedBox(
                height: 50,
              ),
              TextInputField(
                controller: _controller,
                icon: FontAwesomeIcons.thumbsUp,
                hint: 'Gesture',
                obscureText: false,
                Inputtype: TextInputType.name,
                inputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 20,
              ),
              RoundedButton(
                  buttonName: "Detect",
                  onPressed: () {
                    String dt = _controller.text;
                    switch (dt) {
                      case "adha":
                        {
                          setState(() {
                            msg = "assets/gif/adha.gif";
                          });
                        }
                        break;
                      case "agoosthu":
                        {
                          setState(() {
                            msg = "assets/gif/agoosthu.gif";
                          });
                        }
                        break;
                      case "alu":
                        {
                          setState(() {
                            msg = "assets/gif/alu.gif";
                          });
                        }
                        break;
                      case "anthima":
                        {
                          setState(() {
                            msg = "assets/gif/anthima.gif";
                          });
                        }
                        break;

                      case "awurudhdha":
                        {
                          setState(() {
                            msg = "assets/gif/awurudhdha.gif";
                          });
                        }
                        break;

                      case "desamber":
                        {
                          setState(() {
                            msg = "assets/gif/desamber.gif";
                          });
                        }
                        break;
                      case "lamayaa":
                        {
                          setState(() {
                            msg = "assets/gif/lamayaa.gif";
                          });
                        }
                        break;
                      case "medhiyam_rae":
                        {
                          setState(() {
                            msg = "assets/gif/medhiyam_rae.gif";
                          });
                        }
                        break;
                      case "senasuraadhaa":
                        {
                          setState(() {
                            msg = "assets/gif/senasuraadhaa.gif";
                          });
                        }
                        break;
                      case "wathura":
                        {
                          setState(() {
                            msg = "assets/gif/wathura.gif";
                          });
                        }
                        break;
                    }
                  })
            ],
          ),
        ),
      ],
    );
    ;
  }
}
