import 'dart:convert';

import 'package:covid/API/URL.dart';
import 'package:covid/model/data.dart';

import 'package:covid/model/sateDetails.dart';
import 'package:covid/model/summaryList.dart';
import 'package:http/http.dart' as http;

class APIManager {
  var _model;

  Future<List<StateModel>> getStateSummary(String country) async {
    try {
      var response = await http.get(URLs.getState(country));
      if (response.statusCode == 200) {
        var jsonString = jsonDecode(response.body);
        _model = summaryDataFromJson(jsonString);
      }
    } catch (e) {
      return null;
    }
    return _model;
  }

  Future<SummaryData> getCountrySummary(String country) async {
    try {
      var response = await http.get(URLs.getCountry(country));
      if (response.statusCode == 200) {
        var jsonString = jsonDecode(response.body);
        _model = SummaryData.fromJson(jsonString);
      }
    } catch (e) {
      return null;
    }
    return _model;
  }

  Future<SummaryData> getWorldSummary() async {
    try {
      var response = await http.get(URLs.baseUrl);
      if (response.statusCode == 200) {
        var jsonString = jsonDecode(response.body);
        _model = SummaryData.fromJson(jsonString);
      }
    } catch (e) {
      return null;
    }
    return _model;
  }

  Future<List<SummaryList>> getMonthlySummary() async {
    try {
      var response = await http.get(URLs.getMonthlyList());
      if (response.statusCode == 200) {
        var jsonString = jsonDecode(response.body);
        _model = summaryListFromJson(jsonString);
      }
    } catch (e) {
      return null;
    }
    return _model;
  }
}
