import 'package:covid/dashboard/dashboard.dart';
import 'package:covid/dashboard/preventionBlock.dart';
import 'package:covid/model/callData.dart';
import 'package:covid/model/colorData.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DashBoardUpper extends StatelessWidget {
  final width, height, countryName;

  const DashBoardUpper({Key key, this.width, this.height, this.countryName})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
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
            padding:
                EdgeInsets.only(left: 20.0, right: 20.0, top: height * 0.1),
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
                      onPressed: () async {
                        var phone = callData.entries.firstWhere(
                            (element) => element.key == countryName,
                            orElse: () => null);

                        String p = "tel:" + phone.value;
                        if (await canLaunch(p)) await launch(p);
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
      ],
    );
  }
}
