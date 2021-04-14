import 'package:covid/model/colorData.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class RecourseList extends StatelessWidget {
  final height;

  const RecourseList({Key key, this.height}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.6,
      child: ListView(
        children: [
          ListDetail(
            icon: FontAwesomeIcons.images,
            title: "Undraw",
            subtitle: "Illustrations",
            link: "https://undraw.co/illustrations",
          ),
          ListDetail(
            icon: Icons.location_on,
            title: "GeoLocator",
            subtitle: "Location Library",
            link: "https://pub.dev/packages/geolocator",
          ),
          ListDetail(
            icon: Icons.location_city,
            title: "GeoCoder",
            subtitle: "Location Decoding Library",
            link: "https://pub.dev/packages/geocoder",
          ),
          ListDetail(
            icon: FontAwesomeIcons.fontAwesome,
            title: "Font Awesome Icons",
            subtitle: "Icon Library",
            link: "https://pub.dev/packages/font_awesome_flutter",
          ),
          ListDetail(
            icon: Icons.web,
            title: "HTTP",
            subtitle: "URL parser Library",
            link: "https://pub.dev/packages/http",
          ),
          ListDetail(
            icon: Icons.date_range,
            title: "intl",
            subtitle: "Date Time Convertor",
            link: "https://pub.dev/packages/intl",
          ),
          ListDetail(
            icon: FontAwesomeIcons.chartPie,
            title: "Pie Chart",
            subtitle: "Chart Library",
            link: "https://pub.dev/packages/pie_chart",
          ),
          ListDetail(
            icon: FontAwesomeIcons.chartBar,
            title: "FL Chart",
            subtitle: "Chart Library",
            link: "https://pub.dev/packages/fl_chart",
          ),
          ListDetail(
            icon: FontAwesomeIcons.share,
            title: "URL Launcher",
            subtitle: "URL opener library",
            link: "https://pub.dev/packages/url_launcher",
          ),
          ListDetail(
            icon: FontAwesomeIcons.idCard,
            title: "Animated Card",
            subtitle: "Card Library",
            link: "https://pub.dev/packages/animated_card",
          ),
          ListDetail(
            icon: Icons.message,
            title: "Flutter Toast",
            subtitle: "Message Display Library",
            link: "https://pub.dev/packages/toast",
          )
        ],
      ),
    );
  }
}

class ListDetail extends StatelessWidget {
  final icon, title, subtitle, link;
  const ListDetail({
    Key key,
    this.icon,
    this.title,
    this.subtitle,
    this.link,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: textColor,
      ),
      title: Text(
        "$title",
        style: TextStyle(
          color: textColor,
        ),
      ),
      subtitle: Text(
        "$subtitle",
        style: TextStyle(
          color: Colors.grey,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: textColor,
      ),
      onTap: () async {
        if (await canLaunch(link)) launch(link);
      },
    );
  }
}
