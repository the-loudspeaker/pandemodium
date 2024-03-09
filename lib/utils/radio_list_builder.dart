import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pandemonium/model/station.dart';
import 'package:pandemonium/model/station_data.dart';
import 'package:provider/provider.dart';

import 'custom_fonts.dart';
import 'utils.dart';

class RadioListBuilder extends StatelessWidget {
  final List<Station> stationList;
  final int index;
  final VoidCallback? longPressCallback;
  final VoidCallback? onTapCallback;

  const RadioListBuilder({
    super.key,
    required this.stationList,
    required this.index,
    this.longPressCallback,
    this.onTapCallback,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).colorScheme.secondaryContainer,
      onLongPress: longPressCallback,
      onTap: onTapCallback,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              color: Theme.of(context).colorScheme.primary,
              Icons.radio,
              size: 32,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stationList[index].name?.toUpperCase() ?? "",
                    style: MontserratFont.paragraphSemiBold1
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                      stationList[index].homepage?.toLowerCase() ??
                          stationList[index]
                              .urlResolved
                              .toString()
                              .toLowerCase(),
                      style: MontserratFont.captionMedium.copyWith(
                          color: Theme.of(context).colorScheme.secondary),
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis)
                ],
              ),
            ),
            CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Provider.of<StationData>(context).selectedStation.name ==
                      stationList[index].name
                  ? mediaIconWidget(context)
                  : Icon(
                      color: Theme.of(context).colorScheme.primary,
                      Icons.play_arrow),
            ),
          ],
        ),
      ),
    );
  }
}
