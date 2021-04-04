import 'dart:convert';

import 'package:covid/API/URL.dart';

import 'package:covid/model/sateDetails.dart';
import 'package:http/http.dart' as http;

class APIManager {
  var _model;

  Future<List<StateModel>> getSummary(String country) async {
    try {
      var response = await http.get(URLs.getSummary(country));
      if (response.statusCode == 200) {
        var jsonString = jsonDecode(response.body);
        _model = summaryDataFromJson(jsonString);
        var x = 1;
      }
    } catch (e) {
      return null;
    }
    return _model;
  }
}
