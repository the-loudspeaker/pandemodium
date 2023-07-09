import 'dart:convert';
import 'package:pandemonium/model/category_response.dart';
import 'package:pandemonium/model/station_response.dart';
import 'package:http/http.dart' as http;

class RadioService {
  static Future<StationResponse> getPopularStations() async {
    var response = await http.get(Uri.parse(
        'http://all.api.radio-browser.info/json/stations/search?country=India&hidebroken=true&order=votes&reverse=true&limit=5'));
    return StationResponse.fromList(jsonDecode(response.body));
  }
  static Future<CategoryResponse> getCategories() async {
    var response = await http.get(Uri.parse(
        'http://all.api.radio-browser.info/json/tags?order=stationcount&reverse=true&limit=10'));
    return CategoryResponse.fromList(jsonDecode(response.body));
  }
}