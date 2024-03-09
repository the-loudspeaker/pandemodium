import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'station.dart';

class RadioData extends ChangeNotifier {
  List<Station> favStationList = [];

  bool addStation(Station newStation) {
    if (favStationList
        .where((element) => element.stationuuid == newStation.stationuuid)
        .isEmpty) {
      favStationList.add(newStation);
      notifyListeners();
      saveData();
      return true;
    } else {
      return false;
    }
  }

  void removeStation(Station station) {
    favStationList
        .removeWhere((item) => item.stationuuid == station.stationuuid);
    notifyListeners();
    saveData();
  }

  void saveData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String encodedData = encode(favStationList);
      await prefs.setString('radio_data', encodedData);
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  void getData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String taskString = prefs.getString('radio_data').toString();
      List<Station> radioData = decode(taskString);
      favStationList = radioData;
      notifyListeners();
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  static String encode(List<Station> stationList) {
    return jsonEncode(
      stationList
          .map<Map<String, dynamic>>((station) => station.toJson())
          .toList(),
    );
  }

  static List<Station> decode(String stations) {
    var data = (jsonDecode(stations) as List<dynamic>?);
    if (data != null) {
      return (jsonDecode(stations) as List<dynamic>?)!.map<Station>((task) {
        return Station.fromJson(task);
      }).toList();
    } else {
      return <Station>[];
    }
  }
}
