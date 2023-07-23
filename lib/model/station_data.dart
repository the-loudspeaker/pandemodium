import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'station.dart';

class StationData extends ChangeNotifier {
  Station selectedStation = Station();
  MediaStates currentState = MediaStates.end;
  final player = AudioPlayer();
  StationData() {
    _init();
  }

  void playRadio(Station inputStation) async {
    debugPrint(inputStation.urlResolved);
    if (player.playing &&
        inputStation.stationuuid == selectedStation.stationuuid) {
      //Do nothing.
    } else if (!player.playing &&
        inputStation.stationuuid == selectedStation.stationuuid) {
      await player.setUrl(inputStation.urlResolved.toString());
      await player.play();
      selectedStation = inputStation;
    } else {
      await player.stop();
      selectedStation = inputStation;
      await player.setUrl(inputStation.urlResolved.toString());
      await player.play();
    }
    notifyListeners();
    saveLastPlayed();
  }

  void stopRadio() async {
    await player.stop();
    // currentState = MediaStates.stop;
    // selectedStation = inputStation;
    notifyListeners();
    saveLastPlayed();
  }

  void endRadio() async {
    currentState = MediaStates.end;
    stopRadio();
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
      if (currentState != MediaStates.end) {
        currentState == MediaStates.end;
      }
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

  void _init() {
    player.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;
      if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering) {
        currentState = MediaStates.loading;
      } else if (!isPlaying) {
        currentState = MediaStates.stop;
      } else {
        currentState = MediaStates.play;
      }
      notifyListeners();
    });
  }
}

enum MediaStates { play, stop, end, loading }
