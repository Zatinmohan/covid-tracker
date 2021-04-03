import 'package:covid/model/assetData.dart';
import 'package:covid/model/colorData.dart';
import 'package:flutter/material.dart';

class Preventions extends StatelessWidget {
  final width, height;

  const Preventions({Key key, this.width, this.height}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height * 0.32,
      child: Card(
          color: darkTone,
          elevation: 3.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.0)),
          child: Padding(
            padding:
                EdgeInsets.only(left: 20.0, right: 20.0, top: height * 0.03),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Prevention",
                  style: TextStyle(
                    color: textColor,
                    fontSize: width * 0.06,
                    fontWeight: FontWeight.w500,
                  )),
              SizedBox(height: 20.0),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: prevention.length,
                  itemBuilder: (BuildContext context, int index) {
                    String name = prevention[index].name;
                    String image = prevention[index].image;
                    return Container(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: cardColor,
                              radius: height * 0.07,
                              backgroundImage: AssetImage("$image"),
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              "$name",
                              style: TextStyle(
                                color: textColor,
                                fontSize: width * 0.04,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ]),
          )),
    );
  }
}
