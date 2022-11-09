import 'package:flutter/material.dart';
import 'package:mltest/wordToSign.dart';
import 'package:mltest/letsTalk.dart';
import 'package:mltest/learningCenter.dart';
import 'package:mltest/upload.dart';
import 'package:mltest/widgets/roundedButton.dart';
import 'package:mltest/widgets/backgroundImage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(image: 'assets/background.jpg'),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Column(children: [
                  SizedBox(
                    height: 250,
                  ),
                  RoundedButton(
                      buttonName: 'Lets Talk',
                      onPressed: () =>
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LetsTalk(),
                          ))),
                  SizedBox(
                    height: 50,
                  ),
                  RoundedButton(
                      buttonName: 'Word to sign',
                      onPressed: () =>
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => WordtoSign(),
                          ))),
                  SizedBox(
                    height: 50,
                  ),
                  RoundedButton(
                      buttonName: 'Learning Center',
                      onPressed: () =>
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LearningCenter(),
                          ))),
                  SizedBox(
                    height: 50,
                  ),
                  RoundedButton(
                      buttonName: 'Upload and Convert',
                      onPressed: () =>
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Upload(),
                          ))),
                  SizedBox(
                    height: 50,
                  ),
                ]),
              )
            ],
          ),
        )
      ],
    );
  }
}
