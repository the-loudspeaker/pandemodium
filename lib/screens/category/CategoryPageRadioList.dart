import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pandemonium/model/radio_data.dart';
import 'package:pandemonium/model/station.dart';
import 'package:pandemonium/model/station_data.dart';
import 'package:pandemonium/utils/custom_fonts.dart';
import 'package:pandemonium/utils/radio_list_builder.dart';
import 'package:provider/provider.dart';

class CategoryPageRadioList extends StatelessWidget {
  final List<Station> categoryStationList;
  const CategoryPageRadioList({super.key, required this.categoryStationList});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return RadioListBuilder(
            stationList: categoryStationList,
            index: index,
            onTapCallback: () {
              debugPrint(
                  "Clicked on a station ${categoryStationList[index].name}");
              Provider.of<StationData>(context, listen: false)
                  .playRadio(categoryStationList[index]);
            },
            longPressCallback: () {
              bool wasStationAdded = Provider.of<RadioData>(
                  context,
                  listen: false)
                  .addStation(categoryStationList[index]);
              ScaffoldMessenger.of(context)
                  .hideCurrentSnackBar();
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(
                duration: const Duration(seconds: 1),
                showCloseIcon: true,
                closeIconColor: Theme.of(context)
                    .snackBarTheme
                    .closeIconColor,
                margin: EdgeInsets.symmetric(
                    vertical: 64.h, horizontal: 16.w),
                content: Text(
                  wasStationAdded
                      ? "Radio station added to library"
                      : "Radio station exists in library",
                  style: MontserratFont.paragraphSemiBold2
                      .copyWith(
                      color: Theme.of(context)
                          .snackBarTheme
                          .actionTextColor),
                ),
                backgroundColor: Theme.of(context)
                    .snackBarTheme
                    .backgroundColor,
                behavior: SnackBarBehavior.floating,
              ));
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: Theme.of(context).dividerColor,
          );
        },
        itemCount: categoryStationList.length);
  }
}
