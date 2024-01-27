import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pandemonium/model/station_data.dart';
import 'package:provider/provider.dart';

import 'custom_fonts.dart';
import 'utils.dart';

Widget? mediaPlayerBottomSheet(BuildContext context) {
  return Provider.of<StationData>(context).hasSelectedStationAndIsNotEnded
      ? Container(
          height: 64.h,
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Provider.of<StationData>(context)
                              .selectedStation
                              .name
                              ?.toUpperCase() ??
                          "",
                      style: MontserratFont.paragraphSemiBold1.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                        Provider.of<StationData>(context)
                                .selectedStation
                                .homepage
                                ?.toUpperCase() ??
                            "",
                        style: MontserratFont.captionMedium.copyWith(
                            color: Theme.of(context).colorScheme.secondary),
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis)
                  ],
                ),
              ),
              mediaIconWidget(context),
            ],
          ),
        )
      : null;
}
