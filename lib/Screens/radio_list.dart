import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pandemonium/model/station_data.dart';
import 'package:pandemonium/utils/custom_fonts.dart';
import 'package:pandemonium/utils/radio_list_builder.dart';
import 'package:provider/provider.dart';
import 'package:pandemonium/model/radio_data.dart';

class RadioList extends StatelessWidget {
  const RadioList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return RadioListBuilder(
            stationList: Provider.of<RadioData>(context).stationList.reversed.toList(),
            index: index,
            onTapCallback: (){
              debugPrint(
                  "Clicked on a station ${Provider.of<RadioData>(context, listen: false)
                      .stationList.reversed
                      .toList()[index].name}");
              Provider.of<StationData>(context,
                  listen: false)
                  .playRadio(
                  Provider.of<RadioData>(context, listen: false)
                      .stationList.reversed
                      .toList()[index]);
            },
            longPressCallback: () {
              Provider.of<RadioData>(context, listen: false).removeStation(
                  Provider.of<RadioData>(context, listen: false)
                      .stationList.reversed
                      .toList()[index]);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                showCloseIcon: true,
                closeIconColor: Theme.of(context).snackBarTheme.closeIconColor,
                margin: EdgeInsets.symmetric(
                    vertical: 64.h,
                    horizontal: 16.w),
                content: Text(
                  "Radio station removed from library",
                  style: MontserratFont.paragraphSemiBold2
                      .copyWith(color: Theme.of(context).snackBarTheme.actionTextColor),
                ),
                backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
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
        itemCount: Provider.of<RadioData>(context).stationList.length);
  }
}
