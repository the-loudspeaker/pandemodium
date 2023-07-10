import 'station.dart';

class StationResponse {
  List<Station>? stationList;

  StationResponse({this.stationList});

  StationResponse.fromList(List<dynamic> json) {
    stationList = <Station>[];
    for (var element in json) {
      stationList!.add(Station.fromJson(element));
    }
  }
}
