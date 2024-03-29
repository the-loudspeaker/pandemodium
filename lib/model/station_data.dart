import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
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
      await player.setAudioSource(
        AudioSource.uri(Uri.parse(inputStation.urlResolved.toString()),
            tag: MediaItem(
                id: inputStation.stationuuid.toString(),
                title: inputStation.name.toString())),
      );
      await player.play();
      selectedStation = inputStation;
    } else {
      selectedStation = inputStation;
      await player.setAudioSource(
        AudioSource.uri(Uri.parse(inputStation.urlResolved.toString()),
            tag: MediaItem(
                id: inputStation.stationuuid.toString(),
                title: inputStation.name.toString())),
      );
      await player.play();
    }
    notifyListeners();
    saveLastPlayed();
  }

  void stopRadio() async {
    await player.stop();
    currentState = MediaStates.stop;
    notifyListeners();
    saveLastPlayed();
  }

  void destroyRadio() async {
    await player.dispose();
  }

  bool get hasSelectedStationAndIsNotEnded {
    return selectedStation.name != null && currentState != MediaStates.end;
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
