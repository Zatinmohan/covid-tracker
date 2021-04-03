class SummaryData {
  SummaryData({this.confirmed, this.recovered, this.deaths, this.lastUpdated});
  Content confirmed;
  Content recovered;
  Content deaths;
  String lastUpdated;

  factory SummaryData.fromJson(Map<String, dynamic> json) => SummaryData(
        confirmed: Content.fromJson(json["confirmed"]),
        recovered: Content.fromJson(json["recovered"]),
        deaths: Content.fromJson(json["deaths"]),
        lastUpdated:
            json["lastUpdate"].substring(0, 10).split('-').reversed.join('-'),
      );
}

class Content {
  Content({this.value, this.detail});
  int value;
  String detail;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        detail: json["detail"],
        value: json["value"],
      );
}
