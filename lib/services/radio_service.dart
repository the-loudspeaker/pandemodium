import 'dart:convert';
import 'package:pandemonium/model/category_response.dart';
import 'package:pandemonium/model/station_response.dart';
import 'package:http/http.dart' as http;
import 'package:basic_utils/basic_utils.dart';

String baseurl = "http://all.api.radio-browser.info";

class RadioService {
  static Future<StationResponse> getPopularStations() async {
    var response = await http.get(Uri.parse(
        '$baseurl/json/stations/search?hidebroken=true&order=clickcount&reverse=true&lastcheckok=true&country=Ind&limit=5'));
    return StationResponse.fromList(jsonDecode(response.body));
  }

  static Future<StationResponse> getCategoryStations(String query) async {
    var response = await http.get(Uri.parse(
        '$baseurl/json/stations/search?order=clicktrend&reverse=true&limit=11&hidebroken=true&lastcheckok=true&country=India&tag=${query.toLowerCase()}'));
    return StationResponse.fromList(jsonDecode(response.body));
  }

  static Future<StationResponse> searchRadios(String query) async {
    var response = await http.get(Uri.parse(
        '$baseurl/json/stations/search?reverse=true&order=clickcount&hidebroken=true&lastcheckok=true&name=${query.replaceAll(" ", "+")}'));
    return StationResponse.fromList(jsonDecode(response.body));
  }

  static dnsLookup() async {
    // The domain name of the service you want to lookup.
    const String domainName = '_api._tcp.radio-browser.info';
    const String apiEndpoint = 'all.api.radio-browser.info';
    var listOfRecords =
        await DnsUtils.lookupRecord(domainName, RRecordType.SRV);
    if (listOfRecords!.isNotEmpty) {
      baseurl = "http://${listOfRecords.first.data.split(" ").last}";
    } else {
      baseurl = "http://$apiEndpoint";
    }
  }
}
