import 'dart:ui';
import 'package:covid/dashboard/stateDetail.dart';
import 'package:covid/dashboard/upperPart.dart';
import 'package:covid/model/colorData.dart';
import 'package:covid/model/data.dart';
import 'package:covid/model/sateDetails.dart';
import 'package:flutter/material.dart';
import 'infection.dart';

class DashBoard extends StatefulWidget {
  final countryName, stateName, countryData, stateSummaryData;
  const DashBoard({
    Key key,
    this.countryName,
    this.stateName,
    this.countryData,
    this.stateSummaryData,
  }) : super(key: key);
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Column(
          children: [
            DashBoardUpper(width: width, height: height),
            SizedBox(height: 10.0),
            StateWidget(
              width: width,
              height: height,
              state: widget.stateName,
              countryName: widget.countryName,
              summaryData: widget.stateSummaryData,
            ),
            SizedBox(height: 10.0),
            CountryWidget(
              width: width,
              height: height,
              countryName: widget.countryName,
              countryData: widget.countryData,
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ],
    );
  }
}

class CountryWidget extends StatelessWidget {
  const CountryWidget({
    Key key,
    @required this.width,
    @required this.height,
    @required String countryName,
    @required this.countryData,
  })  : _countryName = countryName,
        super(key: key);

  final double width;
  final double height;
  final String _countryName;
  final Future<SummaryData> countryData;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: darkTone,
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.0)),
      child: Padding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: height * 0.03),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Country Tracker",
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w500,
                      fontSize: width * 0.06,
                    )),
                Row(
                  children: [
                    Icon(
                      Icons.place,
                      color: textColor,
                      size: width * 0.08,
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      "$_countryName",
                      style: TextStyle(
                        color: textColor,
                        fontSize: width * 0.045,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10.0),
            InfectionDetails(
              width: width,
              height: height,
              summary: countryData,
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}

class StateWidget extends StatelessWidget {
  const StateWidget({
    Key key,
    @required this.width,
    @required this.height,
    @required String state,
    @required String countryName,
    @required this.summaryData,
  })  : _state = state,
        _countryName = countryName,
        super(key: key);

  final double width;
  final double height;
  final String _state;
  final String _countryName;
  final Future<List<StateModel>> summaryData;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: darkTone,
        elevation: 3.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.0)),
        child: Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20.0, top: height * 0.03),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("State Tracker",
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w500,
                        fontSize: width * 0.06,
                      )),
                  Row(
                    children: [
                      Icon(
                        Icons.place,
                        color: textColor,
                        size: width * 0.08,
                      ),
                      SizedBox(width: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "$_state",
                            style: TextStyle(
                              color: textColor,
                              fontSize: width * 0.045,
                            ),
                          ),
                          SizedBox(height: 2.0),
                          Text(
                            "$_countryName",
                            style: TextStyle(
                              color: textColor,
                              fontSize: width * 0.045,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              StateDetails(
                width: width,
                height: height,
                summary: summaryData,
                state: _state,
              ),
              SizedBox(height: 10.0),
            ],
          ),
        ));
  }
}
