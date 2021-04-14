import 'package:covid/settings/aboutDev.dart';
import 'package:flutter/material.dart';

import 'cardData.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        CardDetails(
          height: height,
          width: width,
          title: "Version",
          data1: "App version ",
          data2: "1.0.0",
        ),
        SizedBox(height: 10.0),
        CardDetails(
          height: height,
          width: width,
          title: "Disclaimer",
          data1: null,
          data2:
              "This data is not approved by government. The data provided to the users is maintained and verified by Hopkins University",
        ),
        SizedBox(height: 10.0),
        CardDetails(
          height: height,
          width: width,
          title: "About Application",
          data1: null,
          data2:
              "This application is for education purpose. The data shown to the user is not officially verified. Also, this application uses the user current location to get the user's state and country stats.",
        ),
        SizedBox(height: 10.0),
        CardDetails(
          width: width,
          height: height,
          title: "Resources/ Plugins used",
          data1: null,
          data2: null,
        ),
        SizedBox(height: 10.0),
        AboutDeveloper(width: width, height: height),
        SizedBox(height: 10.0),
      ],
    );
  }
}
