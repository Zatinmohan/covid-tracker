import 'package:covid/model/colorData.dart';

import 'package:covid/model/sateDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

class StateList extends StatelessWidget {
  final width, height;
  final Future<List<StateModel>> stateList;
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();

  List<DataRow> rowData = [];
  var row = [];
  getData(var snapshot) {
    for (int i = 0; i < snapshot.data.length; i++) {
      rowData.add(buildDataRow(snapshot.data[i], colors[i]));
    }
  }

  DataRow buildDataRow(var data, var color) {
    return DataRow(
        color: MaterialStateProperty.resolveWith<Color>((states) => color),
        cells: [
          DataCell(Text("${data.provinceState}")),
          DataCell(Text("${data.confirmed}")),
          DataCell(Text("${data.recovered}")),
          DataCell(Text("${data.death}")),
        ]);
  }

  StateList({Key key, this.stateList, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  FutureBuilder<List<StateModel>>(
                    future: stateList,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          List<CircularStackEntry> data = <CircularStackEntry>[
                            new CircularStackEntry(
                              <CircularSegmentEntry>[
                                new CircularSegmentEntry(
                                  snapshot.data[0].confirmed.toDouble(),
                                  colors[0],
                                ),
                                new CircularSegmentEntry(
                                  snapshot.data[1].confirmed.toDouble(),
                                  colors[1],
                                ),
                                new CircularSegmentEntry(
                                  snapshot.data[2].confirmed.toDouble(),
                                  colors[2],
                                ),
                                new CircularSegmentEntry(
                                    snapshot.data[3].confirmed.toDouble(),
                                    colors[3]),
                                new CircularSegmentEntry(
                                    snapshot.data[4].confirmed.toDouble(),
                                    colors[4]),
                                new CircularSegmentEntry(
                                    snapshot.data[5].confirmed.toDouble(),
                                    colors[5]),
                                new CircularSegmentEntry(
                                    snapshot.data[6].confirmed.toDouble(),
                                    colors[6]),
                                new CircularSegmentEntry(
                                    snapshot.data[7].confirmed.toDouble(),
                                    colors[7]),
                                new CircularSegmentEntry(
                                    snapshot.data[8].confirmed.toDouble(),
                                    colors[8]),
                                new CircularSegmentEntry(
                                    snapshot.data[9].confirmed.toDouble(),
                                    colors[9]),
                                new CircularSegmentEntry(
                                    snapshot.data[10].confirmed.toDouble(),
                                    colors[10]),
                                new CircularSegmentEntry(
                                    snapshot.data[11].confirmed.toDouble(),
                                    colors[11]),
                                new CircularSegmentEntry(
                                    snapshot.data[12].confirmed.toDouble(),
                                    colors[12]),
                                new CircularSegmentEntry(
                                    snapshot.data[13].confirmed.toDouble(),
                                    colors[13]),
                                new CircularSegmentEntry(
                                    snapshot.data[14].confirmed.toDouble(),
                                    colors[14]),
                                new CircularSegmentEntry(
                                    snapshot.data[15].confirmed.toDouble(),
                                    colors[15]),
                                new CircularSegmentEntry(
                                    snapshot.data[16].confirmed.toDouble(),
                                    colors[16]),
                                new CircularSegmentEntry(
                                    snapshot.data[17].confirmed.toDouble(),
                                    colors[17]),
                                new CircularSegmentEntry(
                                    snapshot.data[18].confirmed.toDouble(),
                                    colors[18]),
                                new CircularSegmentEntry(
                                    snapshot.data[19].confirmed.toDouble(),
                                    colors[19]),
                                new CircularSegmentEntry(
                                    snapshot.data[20].confirmed.toDouble(),
                                    colors[20]),
                                new CircularSegmentEntry(
                                    snapshot.data[21].confirmed.toDouble(),
                                    colors[21]),
                                new CircularSegmentEntry(
                                    snapshot.data[22].confirmed.toDouble(),
                                    colors[22]),
                                new CircularSegmentEntry(
                                    snapshot.data[23].confirmed.toDouble(),
                                    colors[23]),
                                new CircularSegmentEntry(
                                    snapshot.data[24].confirmed.toDouble(),
                                    colors[24]),
                                new CircularSegmentEntry(
                                    snapshot.data[25].confirmed.toDouble(),
                                    colors[25]),
                                new CircularSegmentEntry(
                                    snapshot.data[26].confirmed.toDouble(),
                                    colors[26]),
                                new CircularSegmentEntry(
                                    snapshot.data[27].confirmed.toDouble(),
                                    colors[27]),
                                new CircularSegmentEntry(
                                    snapshot.data[28].confirmed.toDouble(),
                                    colors[28]),
                                new CircularSegmentEntry(
                                    snapshot.data[29].confirmed.toDouble(),
                                    colors[29]),
                                new CircularSegmentEntry(
                                    snapshot.data[30].confirmed.toDouble(),
                                    colors[30]),
                                new CircularSegmentEntry(
                                    snapshot.data[31].confirmed.toDouble(),
                                    colors[31]),
                                new CircularSegmentEntry(
                                    snapshot.data[32].confirmed.toDouble(),
                                    colors[32]),
                                new CircularSegmentEntry(
                                    snapshot.data[33].confirmed.toDouble(),
                                    colors[33]),
                                new CircularSegmentEntry(
                                    snapshot.data[34].confirmed.toDouble(),
                                    colors[34]),
                                new CircularSegmentEntry(
                                    snapshot.data[35].confirmed.toDouble(),
                                    colors[35]),
                              ],
                            ),
                          ];

                          return Card(
                            elevation: 5.0,
                            color: darkTone,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: height * 0.05, left: 20.0, right: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "State Tracker",
                                    style: TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: width * 0.1,
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  AnimatedCircularChart(
                                    key: _chartKey,
                                    size: Size(width * 0.85, height * 0.4),
                                    initialChartData: data,
                                    chartType: CircularChartType.Pie,
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else
                          return Text("No Data");
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                  SizedBox(height: 10.0),
                  FutureBuilder<List<StateModel>>(
                    future: stateList,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          getData(snapshot);
                          return DataTable(
                            dataTextStyle: TextStyle(
                              color: textColor,
                            ),
                            columnSpacing: width * 0.06,
                            columns: [
                              DataColumn(
                                  label: Text(
                                "State",
                                style: TextStyle(
                                  color: textColor,
                                ),
                              )),
                              DataColumn(
                                  label: Text(
                                "Confirmed",
                                style: TextStyle(
                                  color: confirmed,
                                ),
                              )),
                              DataColumn(
                                  label: Text(
                                "Recover",
                                style: TextStyle(
                                  color: recovered,
                                ),
                              )),
                              DataColumn(
                                  label: Text(
                                "Death",
                                style: TextStyle(
                                  color: death,
                                ),
                              )),
                            ],
                            rows: rowData,
                          );
                        } else
                          return Text("NO Data");
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
