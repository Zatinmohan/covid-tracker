import 'package:covid/dashboard/infection.dart';
import 'package:covid/dashboard/stateDetail.dart';
import 'package:covid/model/colorData.dart';
import 'package:covid/model/data.dart';
import 'package:covid/world/graphDetails.dart';
import 'package:flutter/material.dart';

class WorldPage extends StatelessWidget {
  Future<SummaryData> globalData;

  WorldPage({Key key, this.globalData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Column(
          children: [
            GraphCard(
              height: height,
              width: width,
              globalData: globalData,
            ),
            SizedBox(height: 10.0),
            Card(
              elevation: 5.0,
              color: darkTone,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28.0),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    top: height * 0.03, left: 20.0, right: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Global Tracker",
                      style: TextStyle(
                        color: textColor,
                        fontSize: width * 0.08,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    InfectionDetails(
                      height: height,
                      width: width,
                      summary: globalData,
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
