
import 'dart:convert';

import 'package:pandemonium/model/station_response.dart';
import 'package:http/http.dart' as http;

import '../model/station.dart';

class RadioService {
  static Future<StationResponse> getPopularStations() async {
    var response = await http.get(Uri.parse('http://all.api.radio-browser.info/json/stations/topvote/3'));
    return StationResponse.fromList(jsonDecode(response.body));
  }
}