import 'dart:convert';

import 'package:covid/API/URL.dart';
import 'package:covid/model/data.dart';
import 'package:http/http.dart' as http;

class APIManager {
  var _model;

  Future<SummaryData> getSummary(String country) async {
    try {
      var response = await http.get(URLs.getSummary(country));
      if (response.statusCode == 200) {
        var jsonString = jsonDecode(response.body);
        _model = SummaryData.fromJson(jsonString);
      }
    } catch (e) {
      return null;
    }
    return _model;
  }
}
