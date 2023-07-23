import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pandemonium/model/station.dart';

import 'custom_fonts.dart';

class RadioListBuilder extends StatelessWidget {
  final List<Station> stationList;
  final int index;
  final VoidCallback? longPressCallback;
  final VoidCallback? onTapCallback;
  const RadioListBuilder({
    super.key,
    required this.stationList,
    required this.index,
    this.longPressCallback, this.onTapCallback,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).colorScheme.secondary,
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
            const SizedBox(
              width: 8,
            ),
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
                  Text(stationList[index].homepage?.toUpperCase() ?? "",
                      style: MontserratFont.captionMedium.copyWith(
                          color: Theme.of(context).colorScheme.secondary),
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis)
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 1.0,
                ),
              ),
              child: CircleAvatar(
                radius: ScreenUtil().setHeight(16),
                child: Icon(
                    color: Theme.of(context).colorScheme.primary, Icons.play_arrow),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
