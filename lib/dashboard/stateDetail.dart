import 'package:covid/dashboard/statelist.dart';
import 'package:covid/model/colorData.dart';
import 'package:covid/model/sateDetails.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StateDetails extends StatelessWidget {
  const StateDetails(
      {Key key, this.width, this.height, this.summary, this.state})
      : super(key: key);

  String getValues(int value) {
    NumberFormat numberFormat = NumberFormat.decimalPattern('hi');
    return numberFormat.format(value);
  }

  final width, height, summary, state;
  Widget build(BuildContext context) {
    return FutureBuilder<List<StateModel>>(
      future: summary,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none) {
          return Text(
            "No Data",
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w600,
              fontSize: width * 0.08,
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            int i = 0;
            while (i < snapshot.data.length) {
              if (snapshot.data[i].provinceState == state) {
                var dateTime = new DateTime.fromMillisecondsSinceEpoch(
                    snapshot.data[i].lastUpdate);
                var readableDate = DateFormat.yMMMd().format(dateTime);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Last Updated: $readableDate",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        IconButton(
                            icon: Icon(Icons.arrow_forward, color: textColor),
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => StateList(
                                          stateList: summary,
                                          width: width,
                                          height: height,
                                        )))),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    RowLayout(
                      width: width,
                      color1: confirmed,
                      color2: recovered,
                      subtitle1: "Confirmed",
                      subtitle2: "Recovered",
                      data1: getValues(snapshot.data[i].confirmed),
                      data2: getValues(snapshot.data[i].recovered),
                      icon1: Icons.verified,
                      icon2: Icons.recommend,
                    ),
                    SizedBox(height: 5.0),
                    RowLayout(
                      width: width,
                      color1: active,
                      color2: death,
                      subtitle1: "Active",
                      subtitle2: "Death",
                      data1: getValues(snapshot.data[i].active),
                      data2: getValues(snapshot.data[i].death),
                      icon1: Icons.verified,
                      icon2: Icons.dangerous,
                    ),
                  ],
                );
              }
              i++;
            }
            return Text("State not found");
          } else
            return Text("No Data");
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

class RowLayout extends StatelessWidget {
  const RowLayout({
    Key key,
    @required this.width,
    this.color1,
    this.color2,
    this.subtitle1,
    this.subtitle2,
    this.data1,
    this.data2,
    this.icon1,
    this.icon2,
  }) : super(key: key);

  final width;
  final color1, color2, subtitle1, subtitle2, data1, data2, icon1, icon2;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            width: width * 0.5,
            height: width * 0.33,
            child: Card(
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: cardColor,
                child: CardDetails(
                  icon: icon1,
                  color: color1,
                  data: data1,
                  width: width,
                  subtitle: subtitle1,
                )),
          ),
        ),
        Expanded(
          child: Container(
            width: width * 0.5,
            height: width * 0.33,
            child: Card(
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: cardColor,
                child: CardDetails(
                  icon: icon2,
                  color: color2,
                  data: data2,
                  width: width,
                  subtitle: subtitle2,
                )),
          ),
        ),
      ],
    );
  }
}

class CardDetails extends StatelessWidget {
  const CardDetails({
    Key key,
    @required this.icon,
    @required this.color,
    @required this.data,
    @required this.width,
    @required this.subtitle,
  }) : super(key: key);

  final icon;
  final color;
  final data;
  final width;
  final subtitle;

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
