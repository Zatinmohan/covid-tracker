import 'package:covid/dashboard/dashboard.dart';
import 'package:covid/model/summaryList.dart';
import 'package:covid/settings/settings.dart';
import 'package:covid/world/world.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:toast/toast.dart';

import 'API/api.dart';
import 'model/colorData.dart';
import 'model/data.dart';
import 'model/sateDetails.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  String _countryName;
  String _state;
  Future<List<StateModel>> stateSummaryData;
  Future<List<SummaryList>> summaryList;

  Future<SummaryData> countryData;
  Future<SummaryData> worldData;

  @override
  void initState() {
    super.initState();
    if (worldData == null) worldData = APIManager().getWorldSummary();
    if (_state == null || _countryName == null) getLocation();
    if (summaryList == null) summaryList = APIManager().getMonthlySummary();
  }

  Future<void> getLocation() async {
    bool serviceEnabled;

    LocationPermission permission;

    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled)
        return Future.error("Location Services are Disabled");
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          Toast.show("Location permission is permantely denied", context);
          return Future.error(
              "Location permission are permantely denied, we cannot request permission");
        }

        if (permission == LocationPermission.denied) {
          Toast.show("Location permission is denied", context);
          return Future.error("Location permission is denied");
        }
      }

      var location = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      final coordinates =
          new Coordinates(location.latitude, location.longitude);
      List<Address> address =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);

      setState(() {
        _countryName = address[0].countryName;
        _state = address[0].adminArea;

        stateSummaryData =
            APIManager().getStateSummary(_countryName.toString());
        countryData = APIManager().getCountrySummary(_countryName.toString());
      });
    } catch (e) {
      return null;
    }
  }

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: _selectedIndex == 0
              ? DashBoard(
                  countryName: _countryName,
                  stateName: _state,
                  countryData: countryData,
                  stateSummaryData: stateSummaryData,
                )
              : (_selectedIndex == 1
                  ? WorldPage(
                      globalData: worldData,
                      summaryList: summaryList,
                    )
                  : SettingPage()),
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(28.0)),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          showUnselectedLabels: false,
          backgroundColor: darkTone,
          currentIndex: _selectedIndex,
          onTap: _onItemTap,
          selectedIconTheme: IconThemeData(color: Colors.grey),
          selectedLabelStyle: TextStyle(color: Colors.grey),
          iconSize: 22,
          elevation: 8,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
              backgroundColor: darkTone,
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.globe),
              title: Text("World"),
              backgroundColor: darkTone,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text("Setting"),
              backgroundColor: darkTone,
            ),
          ],
        ),
      ),
    );
  }
}
