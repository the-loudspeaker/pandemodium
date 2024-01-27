import 'package:flutter/material.dart';
import 'package:pandemonium/model/station_data.dart';
import 'package:provider/provider.dart';

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

Widget mediaIconWidget(BuildContext context) {
  switch (Provider.of<StationData>(context).currentState) {
    case MediaStates.play:
      return IconButton(
        onPressed: () {
          Provider.of<StationData>(context, listen: false).stopRadio();
        },
        icon: Icon(color: Theme.of(context).colorScheme.primary, Icons.stop),
      );
    case MediaStates.loading:
      return IconButton(
        icon: Icon(Icons.circle_outlined,
            color: Theme.of(context).colorScheme.primary),
        onPressed: null,
      );
    default:
      return IconButton(
        icon: Icon(
            color: Theme.of(context).colorScheme.primary, Icons.play_arrow),
        onPressed: () {
          Provider.of<StationData>(context, listen: false).playRadio(
              Provider.of<StationData>(context, listen: false).selectedStation);
        },
      );
  }
}

class NoScrollGlowBehaviour extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
