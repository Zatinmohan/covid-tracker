import 'package:covid/model/colorData.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'resourceList.dart';

class CardDetails extends StatefulWidget {
  final height, width;
  final String title, data1, data2;

  CardDetails(
      {Key key, this.height, this.width, this.title, this.data1, this.data2})
      : super(key: key);

  @override
  _CardDetailsState createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetails> {
  bool _onPress = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: darkTone,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28.0),
      ),
      child: Padding(
        padding:
            EdgeInsets.only(top: widget.height * 0.03, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${widget.title}",
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w500,
                    fontSize: widget.data1 != null
                        ? widget.width * 0.07
                        : widget.width * 0.06,
                  ),
                ),
                widget.data1 == null
                    ? IconButton(
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: textColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _onPress = !_onPress;
                          });
                        },
                      )
                    : SizedBox.shrink(),
              ],
            ),
            SizedBox(height: 10.0),
            _onPress ? RecourseList(height: widget.height) : SizedBox.shrink(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.data1 != null
                    ? Flexible(
                        child: Text(
                          "${widget.data1}",
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w400,
                            fontSize: widget.width * 0.06,
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
                widget.data2 != null
                    ? Text(
                        "${widget.data2}",
                        style: TextStyle(
                          color: textColor,
                          fontSize: widget.width * 0.05,
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            ),
            SizedBox(height: 5.0),
            widget.data2 == null && widget.data1 != null
                ? RaisedButton.icon(
                    color: backgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                    onPressed: () async {
                      if (await canLaunch(
                          "https://github.com/mathdroid/covid-19-api"))
                        launch("https://github.com/mathdroid/covid-19-api");
                    },
                    icon: Icon(FontAwesomeIcons.github),
                    label: Text(
                      "Covid API",
                      style: TextStyle(
                        color: textColor,
                        fontSize: widget.width * 0.05,
                      ),
                    ))
                : SizedBox.shrink(),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
