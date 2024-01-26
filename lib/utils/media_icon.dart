import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/station_data.dart';

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
