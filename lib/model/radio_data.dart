import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'station.dart';

class RadioData extends ChangeNotifier {
  Set<Station> stationSet = {};

  void addStation(Station newStation) {
    if (stationSet
        .where((element) => element.stationuuid == newStation.stationuuid)
        .isEmpty) {
      stationSet.add(newStation);
      notifyListeners();
      saveData();
    }
  }

  void removeStation(Station station) {
    stationSet.removeWhere((item) => item.stationuuid == station.stationuuid);
    notifyListeners();
    saveData();
  }

  void saveData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String encodedData = encode(stationSet.toList());
      await prefs.setString('radio_data', encodedData);
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  void getData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String taskString = prefs.getString('radio_data').toString();
      Set<Station> radioData = decode(taskString);
      stationSet = radioData;
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

  static Set<Station> decode(String stations) {
    var data = (jsonDecode(stations) as List<dynamic>?);
    if (data != null) {
      return (jsonDecode(stations) as List<dynamic>?)!
          .map<Station>((task) {
            return Station.fromJson(task);
          })
          .toList()
          .toSet();
    } else {
      return <Station>{};
    }
  }
}
