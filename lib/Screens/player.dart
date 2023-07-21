import 'package:flutter/material.dart';
import 'package:pandemonium/model/station.dart';

class PlayerScreen extends StatelessWidget {
  final Station station;
  const PlayerScreen({super.key, required this.station});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(),
    );
  }
}
