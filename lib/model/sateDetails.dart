List<StateModel> summaryDataFromJson(var str) =>
    List<StateModel>.from(str.map((x) => StateModel.fromJson(x)));

class StateModel {
  StateModel({
    this.confirmed,
    this.active,
    this.death,
    this.recovered,
    this.lastUpdate,
    this.provinceState,
  });

  int confirmed, active, death, recovered;
  int lastUpdate;
  String provinceState;

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
        confirmed: json["confirmed"],
        active: json["active"],
        recovered: json["recovered"],
        death: json["deaths"],
        lastUpdate: json["lastUpdate"],
        provinceState: json["provinceState"],
      );
}
