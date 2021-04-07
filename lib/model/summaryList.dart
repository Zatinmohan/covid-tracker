List<SummaryList> summaryListFromJson(var str) =>
    List<SummaryList>.from(str.map((x) => SummaryList.fromJson(x)));

class SummaryList {
  SummaryList({
    this.confirmed,
    this.death,
    this.reportDate,
  });
  Confirmed confirmed;
  Confirmed death;
  String reportDate;

  factory SummaryList.fromJson(Map<String, dynamic> json) => SummaryList(
        confirmed: Confirmed.fromJson(json["confirmed"]),
        death: Confirmed.fromJson(json["deaths"]),
        reportDate: json["reportDate"],
      );
}

class Confirmed {
  Confirmed({
    this.total,
  });

  int total;

  factory Confirmed.fromJson(Map<dynamic, dynamic> json) => Confirmed(
        total: json["total"].toInt(),
      );
}
