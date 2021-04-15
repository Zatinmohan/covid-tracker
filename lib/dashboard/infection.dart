import 'package:covid/model/colorData.dart';
import 'package:covid/model/data.dart';
import 'package:covid/world/barGraph.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

class InfectionDetails extends StatefulWidget {
  final width, height, summary, graphData, pageno;

  InfectionDetails(
      {Key key,
      this.width,
      this.height,
      this.summary,
      this.graphData,
      this.pageno})
      : super(key: key);

  @override
  _InfectionDetailsState createState() => _InfectionDetailsState();
}

class _InfectionDetailsState extends State<InfectionDetails> {
  bool _isConfirmed = false, _isDeath = false;

  String getValues(int value) {
    NumberFormat numberFormat = NumberFormat.decimalPattern('hi');
    return numberFormat.format(value);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SummaryData>(
      future: widget.summary,
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
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isConfirmed = !_isConfirmed;
                              });
                            },
                            child: TrackerWidget(
                              width: widget.width,
                              color: confirmed,
                              subtitle: "Confirmed",
                              data: getValues(
                                snapshot.data.confirmed.value,
                              ),
                              icon: Icons.verified,
                              page: widget.pageno,
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (widget.pageno == 2)
                                  Toast.show("No Recovery Data", context);
                              });
                            },
                            child: TrackerWidget(
                              width: widget.width,
                              color: recovered,
                              subtitle: "Recovered",
                              data: getValues(
                                snapshot.data.recovered.value,
                              ),
                              icon: Icons.recommend,
                              page: widget.pageno,
                            ),
                          ),
                        ),
                      ],
                    ),
                    _isConfirmed && widget.graphData != null
                        ? BarGraph(
                            width: widget.width,
                            height: widget.height,
                            summaryList: widget.graphData,
                            color: confirmed,
                            confirmedVerified: true,
                          )
                        : SizedBox.shrink(),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isDeath = !_isDeath;
                    });
                  },
                  child: Container(
                    width: widget.width,
                    child: Card(
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: cardColor,
                      child: CardDetails(
                        color: death,
                        width: widget.width,
                        subtitle: "Death",
                        data: getValues(snapshot.data.deaths.value),
                        icon: Icons.dangerous,
                        page: widget.pageno,
                      ),
                    ),
                  ),
                ),
                _isDeath && widget.graphData != null
                    ? BarGraph(
                        width: widget.width,
                        height: widget.height,
                        summaryList: widget.graphData,
                        color: death,
                        confirmedVerified: false,
                      )
                    : SizedBox.shrink(),
              ],
            );
          } else {
            return Center(
                child: Text(
              "No Data",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: widget.width * 0.05,
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
    this.page,
  }) : super(key: key);

  final width, color, subtitle, data, icon, page;

  @override
  Widget build(BuildContext context) {
    return Card(
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
        page: page,
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
    this.page,
  }) : super(key: key);

  final color;
  final width;
  final subtitle;
  final data;
  final icon;
  final page;

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
          page == 2
              ? Align(
                  alignment: Alignment.bottomRight,
                  child: Icon(
                    Icons.arrow_downward,
                    color: Colors.grey,
                    size: 18.0,
                  ))
              : SizedBox.shrink()
        ],
      ),
    );
  }
}
