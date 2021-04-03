import 'package:covid/model/colorData.dart';
import 'package:covid/model/data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class InfectionDetails extends StatelessWidget {
  String getValues(int value) {
    NumberFormat numberFormat = NumberFormat.decimalPattern('hi');
    return numberFormat.format(value);
  }

  final width, height, summary;

  const InfectionDetails({Key key, this.width, this.height, this.summary})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SummaryData>(
      future: summary,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Last Updated: ${snapshot.data.lastUpdated}",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  children: [
                    TrackerWidget(
                      width: width,
                      color: confirmed,
                      subtitle: "Confirmed",
                      data: getValues(
                        snapshot.data.confirmed.value,
                      ),
                      icon: Icons.verified,
                    ),
                    TrackerWidget(
                      width: width,
                      color: recovered,
                      subtitle: "Recovered",
                      data: getValues(
                        snapshot.data.recovered.value,
                      ),
                      icon: Icons.recommend,
                    ),
                  ],
                ),
                Container(
                  width: width * 0.86,
                  height: height * 0.2,
                  child: Card(
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: cardColor,
                    child: CardDetails(
                        color: death,
                        width: width,
                        subtitle: "Death",
                        data: getValues(snapshot.data.deaths.value),
                        icon: Icons.dangerous),
                  ),
                ),
              ],
            );
          } else {
            return Center(
                child: Text(
              "No Data",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: width * 0.05,
                color: textColor,
              ),
            ));
          }
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

class TrackerWidget extends StatelessWidget {
  const TrackerWidget({
    Key key,
    @required this.width,
    this.color,
    this.data,
    this.subtitle,
    this.icon,
  }) : super(key: key);

  final width, color, subtitle, data, icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: width * 0.5,
        height: width * 0.35,
        child: Card(
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: cardColor,
          child: CardDetails(
            color: color,
            width: width,
            subtitle: subtitle,
            data: data,
            icon: icon,
          ),
        ),
      ),
    );
  }
}

class CardDetails extends StatelessWidget {
  const CardDetails({
    Key key,
    @required this.color,
    @required this.width,
    @required this.subtitle,
    this.data,
    this.icon,
  }) : super(key: key);

  final color;
  final width;
  final subtitle;
  final data;
  final icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: color,
          ),
          SizedBox(height: 10.0),
          Text(
            "$data",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: width * 0.05,
              color: color,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            "$subtitle",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: width * 0.05,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
