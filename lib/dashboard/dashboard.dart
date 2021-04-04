import 'dart:ui';
import 'package:covid/API/api.dart';

import 'package:covid/dashboard/preventionBlock.dart';
import 'package:covid/dashboard/stateDetail.dart';
import 'package:covid/model/colorData.dart';
import 'package:covid/model/data.dart';
import 'package:covid/model/sateDetails.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

import 'infection.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  String _countryName;
  String _state;

  Future<List<StateModel>> stateSummaryData;
  Future<SummaryData> countryData;
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  Future<void> getLocation() async {
    bool serviceEnabled;

    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) return Future.error("Location Services are Disabled");
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever)
        return Future.error(
            "Location permission are permantely denied, we cannot request permission");

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission is denied");
      }
    }

    var location = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    final coordinates = new Coordinates(location.latitude, location.longitude);
    List<Address> address =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);

    setState(() {
      _countryName = address[0].countryName;
      _state = address[0].adminArea;

      stateSummaryData = APIManager().getStateSummary(_countryName.toString());
      countryData = APIManager().getCountrySummary(_countryName.toString());
    });
  }

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Card(
                  color: darkTone,
                  elevation: 3.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(28.0),
                    bottomRight: Radius.circular(28.0),
                  )),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20.0, top: height * 0.1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Covid-19 App",
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w600,
                            fontSize: width * 0.08,
                          ),
                        ),
                        SizedBox(height: 30.0),
                        Text(
                          "Are you feeling sick?",
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w500,
                            fontSize: width * 0.07,
                          ),
                        ),
                        SizedBox(height: 12.0),
                        Text(
                          "If you feel sick with any of covid-19 symptoms please contact the concern authorities.",
                          style: TextStyle(
                            color: Color(0xffFCFCFD),
                            fontWeight: FontWeight.w400,
                            fontSize: width * 0.04,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.08,
                        ),
                        Center(
                          child: Container(
                            width: width * 0.4,
                            height: height * 0.07,
                            child: RaisedButton(
                              onPressed: () {
                                print("HelpLine pressed");
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              color: Color(0xffFA3C24),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.call,
                                    color: textColor,
                                  ),
                                  SizedBox(width: 8.0),
                                  Text(
                                    "Call Now",
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: width * 0.05,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 28.0),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Preventions(width: width, height: height),
                SizedBox(height: 10.0),
                StateWidget(
                  width: width,
                  height: height,
                  state: _state,
                  countryName: _countryName,
                  summaryData: stateSummaryData,
                ),
                SizedBox(height: 10.0),
                CountryWidget(
                  width: width,
                  height: height,
                  countryName: _countryName,
                  countryData: countryData,
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(28.0)),
        child: BottomNavigationBar(
          showUnselectedLabels: false,
          backgroundColor: darkTone,
          currentIndex: _selectedIndex,
          onTap: _onItemTap,
          selectedIconTheme: IconThemeData(color: Colors.grey),
          selectedLabelStyle: TextStyle(color: Colors.grey),
          iconSize: 25,
          elevation: 8,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.globe),
              title: Text("World"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text("Setting"),
            ),
          ],
        ),
      ),
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
