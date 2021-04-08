import 'package:covid/model/colorData.dart';
import 'package:covid/model/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
// import 'package:flutter_circular_chart/flutter_circular_chart.dart';

class GraphCard extends StatelessWidget {
  final width, height;

  final Future<SummaryData> globalData;

  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();

  GraphCard({Key key, this.width, this.height, this.globalData})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: darkTone,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(28.0),
              bottomRight: Radius.circular(28.0))),
      child: Padding(
        padding: EdgeInsets.only(top: height * 0.07, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Covid-19 Outbreak",
              style: TextStyle(
                color: textColor,
                fontSize: width * 0.08,
                fontWeight: FontWeight.w600,
              ),
            ),
            //SizedBox(height: 8.0),
            FutureBuilder<SummaryData>(
                future: globalData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      // List<PieChartSectionData> data = [
                      //   PieChartSectionData(
                      //     value: snapshot.data.confirmed.value.toDouble(),
                      //     color: confirmed,
                      //     radius: width * 0.25,
                      //     showTitle: false,
                      //   ),
                      //   PieChartSectionData(
                      //     value: snapshot.data.recovered.value.toDouble(),
                      //     color: recovered,
                      //     radius: width * 0.25,
                      //     showTitle: false,
                      //   ),
                      //   PieChartSectionData(
                      //     value: snapshot.data.deaths.value.toDouble(),
                      //     color: death,
                      //     radius: width * 0.25,
                      //     showTitle: false,
                      //   ),
                      // ];
                      List<CircularStackEntry> data = <CircularStackEntry>[
                        new CircularStackEntry(<CircularSegmentEntry>[
                          new CircularSegmentEntry(
                              snapshot.data.confirmed.value.toDouble(),
                              confirmed),
                          new CircularSegmentEntry(
                              snapshot.data.recovered.value.toDouble(),
                              recovered),
                          new CircularSegmentEntry(
                              snapshot.data.deaths.value.toDouble(), death),
                        ])
                      ];
                      return Row(
                        children: [
                          // Container(
                          //   width: width * 0.5,
                          //   height: height * 0.32,
                          //   child: PieChart(
                          //     PieChartData(
                          //       startDegreeOffset: 270,
                          //       sectionsSpace: 0,
                          //       centerSpaceRadius: 0,
                          //       sections: data,
                          //       borderData: FlBorderData(
                          //         show: false,
                          //       ),
                          //     ),
                          //     swapAnimationDuration:
                          //         Duration(milliseconds: 400),
                          //   ),
                          // ),
                          AnimatedCircularChart(
                            key: _chartKey,
                            size: Size(width * 0.6, height * 0.32),
                            initialChartData: data,
                            chartType: CircularChartType.Pie,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ChartDetails(
                                  data: "Confirmed",
                                  color: confirmed,
                                  height: height,
                                  width: width),
                              SizedBox(height: 8.0),
                              ChartDetails(
                                  data: "Recovered",
                                  color: recovered,
                                  height: height,
                                  width: width),
                              SizedBox(height: 8.0),
                              ChartDetails(
                                  data: "Death",
                                  color: death,
                                  height: height,
                                  width: width),
                            ],
                          ),
                        ],
                      );
                    } else
                      return Text("No Data");
                  }
                  return CircularProgressIndicator();
                }),
          ],
        ),
      ),
    );
  }
}

class ChartDetails extends StatelessWidget {
  const ChartDetails({
    Key key,
    @required this.height,
    @required this.width,
    this.color,
    this.data,
  }) : super(key: key);

  final color, data;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: height * 0.02,
          width: width * 0.035,
          color: color,
        ),
        SizedBox(width: 5.0),
        Text(
          "$data",
          style: TextStyle(
            color: textColor,
            fontSize: width * 0.04,
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    );
  }
}
