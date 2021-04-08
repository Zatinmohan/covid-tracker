import 'package:covid/model/colorData.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutDeveloper extends StatefulWidget {
  final height, width;

  AboutDeveloper({Key key, this.height, this.width}) : super(key: key);
  @override
  _AboutDeveloperState createState() => _AboutDeveloperState();
}

class _AboutDeveloperState extends State<AboutDeveloper> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: darkTone,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28.0),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(
              top: widget.height * 0.03, left: 20.0, right: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "About Developer",
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w400,
                      fontSize: widget.width * 0.06,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: textColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                  )
                ],
              ),
              SizedBox(height: 10.0),
              _isExpanded
                  ? Column(
                      children: [
                        CircleAvatar(
                          radius: widget.width * 0.3,
                          backgroundImage: AssetImage('assets/dev.jpg'),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          "Jatin Mohan",
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w600,
                            fontSize: widget.width * 0.07,
                          ),
                        ),
                        Text(
                          "Engineer by day, pimp by night",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: widget.width * 0.035,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(
                                FontAwesomeIcons.facebookF,
                                color: textColor,
                              ),
                              onPressed: () async {
                                if (await canLaunch(
                                    "https://www.facebook.com/iamzatin")) {
                                  launch("https://www.facebook.com/iamzatin");
                                }
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                FontAwesomeIcons.instagram,
                                color: textColor,
                              ),
                              onPressed: () async {
                                if (await canLaunch(
                                    "https://www.instagram.com/o.my.god.someone_actually/")) {
                                  launch(
                                      "https://www.instagram.com/o.my.god.someone_actually/");
                                }
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                FontAwesomeIcons.linkedin,
                                color: textColor,
                              ),
                              onPressed: () async {
                                if (await canLaunch(
                                    "https://www.linkedin.com/in/jatin-mohan/")) {
                                  launch(
                                      "https://www.linkedin.com/in/jatin-mohan/");
                                }
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                FontAwesomeIcons.github,
                                color: textColor,
                              ),
                              onPressed: () async {
                                if (await canLaunch(
                                    "https://github.com/Zatinmohan")) {
                                  launch("https://github.com/Zatinmohan");
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
