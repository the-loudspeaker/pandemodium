import 'dart:convert';
import 'package:pandemonium/model/station_response.dart';
import 'package:http/http.dart' as http;
import 'package:basic_utils/basic_utils.dart';

final String baseurl = "https://de1.api.radio-browser.info";

class RadioService {
  static Future<StationResponse> getPopularStations() async {
    try {
      var response = await http.get(Uri.parse(
          '$baseurl/json/stations/search?hidebroken=true&order=clickcount&reverse=true&lastcheckok=true&country=Ind&limit=5'));
      if(response.statusCode != 200) return Future.error(response.body);
      return StationResponse.fromList(jsonDecode(response.body));
    } on Exception catch (e) {
      return Future.error(e);
    }
  }

  static Future<StationResponse> getCategoryStations(String query) async {
    try {
      var response = await http.get(Uri.parse(
          '$baseurl/json/stations/search?order=clicktrend&reverse=true&limit=50&hidebroken=true&lastcheckok=true&country=India&tag=${query.toLowerCase()}'));
      if(response.statusCode != 200) return Future.error(response.body);
      return StationResponse.fromList(jsonDecode(response.body));
    } on Exception catch (e) {
      return Future.error(e);
    }
  }

  static Future<StationResponse> searchRadios(String query) async {
    try {
      var response = await http.get(Uri.parse(
          '$baseurl/json/stations/search?reverse=true&order=clickcount&hidebroken=true&lastcheckok=true&name=${query.replaceAll(" ", "+")}'));
      if(response.statusCode != 200) return Future.error(response.body);
      return StationResponse.fromList(jsonDecode(response.body));
    } on Exception catch (e) {
      return Future.error(e);
    }
  }

  static Future<String> fetchBaseUrl() async {
    const String domainName = 'all.api.radio-browser.info';
    try {
      var listOfRecords = await DnsUtils.lookupRecord(domainName, RRecordType.A);
      if (listOfRecords!.isNotEmpty) {
        listOfRecords.shuffle();
        print(listOfRecords.first.data);
        return Future.value("https://${listOfRecords.first.data}");
      } else {
        return Future.value("https://$domainName");
      }
    } on Exception catch (_) {
      return Future.value("https://$domainName");
    }
  }
}
