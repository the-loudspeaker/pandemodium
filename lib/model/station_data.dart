import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'station.dart';

class StationData extends ChangeNotifier {
  Station selectedStation = Station();
  MediaStates currentState = MediaStates.end;
  final player = AudioPlayer();

  void playRadio( Station inputStation ) async {
    debugPrint(inputStation.urlResolved);
    switch(currentState){
      case MediaStates.play:
        if(inputStation.stationuuid!=selectedStation.stationuuid){
          await player.stop();
          await player.play(inputStation.urlResolved.toString(), isLocal: false);
        }
        break;
      case MediaStates.stop:
        await player.play(inputStation.urlResolved.toString(), isLocal: false);
        break;
      case MediaStates.end:
        await player.play(inputStation.urlResolved.toString(), isLocal: false);
        break;
      case MediaStates.loading:
        break;
    }
    currentState=MediaStates.play;
    selectedStation = inputStation;
    notifyListeners();
    saveLastPlayed();
  }

  void stopRadio(Station inputStation) async {
    await player.stop();
    currentState=MediaStates.stop;
    selectedStation = inputStation;
    notifyListeners();
    saveLastPlayed();
  }

  void endRadio() async {
    await player.stop();
    await player.release();
    currentState=MediaStates.end;
    notifyListeners();
    saveLastPlayed();
  }

  void saveLastPlayed() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String encodedData = encode(selectedStation);
      await prefs.setString('last_played', encodedData);
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  void getLastPlayed() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String lastStation = prefs.getString('last_played').toString();
      Station stationData = decode(lastStation);
      selectedStation = stationData;
      notifyListeners();
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  static String encode(Station station) {
    return jsonEncode(station.toJson());
  }

  static Station decode(String lastStation) {
    var data = (jsonDecode(lastStation));
    if (data != null) {
      return Station.fromJson(data);
    } else {
      return Station();
    }
  }
}

enum MediaStates {
  play, stop, end, loading
}