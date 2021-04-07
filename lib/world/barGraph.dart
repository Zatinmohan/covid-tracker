import 'package:covid/model/colorData.dart';
import 'package:covid/model/summaryList.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarGraph extends StatefulWidget {
  final width, height, color;
  bool confirmedVerified;
  Future<List<SummaryList>> summaryList;

  BarGraph({
    Key key,
    this.width,
    this.height,
    this.summaryList,
    this.color,
    this.confirmedVerified,
  }) : super(key: key);

  @override
  _BarGraphState createState() => _BarGraphState();
}

class _BarGraphState extends State<BarGraph> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28.0),
      ),
      child: FutureBuilder<List<SummaryList>>(
        future: widget.summaryList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              int length = snapshot.data.length;
              return AspectRatio(
                aspectRatio: 1,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: BarChart(
                    BarChartData(
                      //alignment: BarChartAlignment.spaceAround,
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: SideTitles(
                          showTitles: true,
                          rotateAngle: 320.0,
                          getTextStyles: (value) => const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                          margin: 20,
                          getTitles: (double value) {
                            switch (value.toInt()) {
                              case 0:
                                return '${snapshot.data[length - 5].reportDate}';
                              case 1:
                                return '${snapshot.data[length - 4].reportDate}';
                              case 2:
                                return '${snapshot.data[length - 3].reportDate}';
                              case 3:
                                return '${snapshot.data[length - 2].reportDate}';
                              case 4:
                                return '${snapshot.data[length - 1].reportDate}';
                              default:
                                return '';
                            }
                          },
                        ),
                        leftTitles: SideTitles(
                          showTitles: true,
                          getTextStyles: (value) => const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          margin: 32,
                          reservedSize: 20,
                          interval:
                              widget.confirmedVerified ? 10000000 : 1000000,
                          getTitles: (value) {
                            if (value == 0) return '0';
                            if (widget.confirmedVerified) {
                              if (value == 50000000) return '50m';
                              if (value >= 100000000.0 && value < 101000000.0)
                                return '100m';
                              else if (value >= 101000000.0 &&
                                  value < 102000000.0)
                                return '101m';
                              else if (value >= 102000000.0 &&
                                  value < 103000000.0)
                                return '102m';
                              else if (value >= 103000000.0 &&
                                  value < 104000000.0)
                                return '103m';
                              else if (value >= 104000000.0 &&
                                  value < 105000000.0)
                                return '104m';
                              else
                                return '';
                            } else {
                              if (value >= 500000 && value < 1000000)
                                return '500k';
                              else if (value >= 1000000 && value < 2000000)
                                return '1m';
                              else if (value >= 2000000 && value < 3000000)
                                return '2m';
                              else if (value >= 3000000 && value < 4000000)
                                return '3m';
                              else
                                return '';
                            }
                          },
                        ),
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      barGroups: [
                        BarChartGroupData(
                          x: 0,
                          barRods: [
                            BarChartRodData(
                              y: widget.confirmedVerified
                                  ? snapshot.data[length - 5].confirmed.total
                                      .toDouble()
                                  : snapshot.data[length - 5].death.total
                                      .toDouble(),
                              colors: [
                                widget.color,
                              ],
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 1,
                          barRods: [
                            BarChartRodData(
                              y: widget.confirmedVerified
                                  ? snapshot.data[length - 4].confirmed.total
                                      .toDouble()
                                  : snapshot.data[length - 4].death.total
                                      .toDouble(),
                              colors: [
                                widget.color,
                              ],
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 2,
                          barRods: [
                            BarChartRodData(
                              y: widget.confirmedVerified
                                  ? snapshot.data[length - 3].confirmed.total
                                      .toDouble()
                                  : snapshot.data[length - 3].death.total
                                      .toDouble(),
                              colors: [
                                widget.color,
                              ],
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 3,
                          barRods: [
                            BarChartRodData(
                              y: widget.confirmedVerified
                                  ? snapshot.data[length - 2].confirmed.total
                                      .toDouble()
                                  : snapshot.data[length - 2].death.total
                                      .toDouble(),
                              colors: [
                                widget.color,
                              ],
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 4,
                          barRods: [
                            BarChartRodData(
                              y: widget.confirmedVerified
                                  ? snapshot.data[length - 1].confirmed.total
                                      .toDouble()
                                  : snapshot.data[length - 1].death.total
                                      .toDouble(),
                              colors: [
                                widget.color,
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else
              return Text("No Data");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
