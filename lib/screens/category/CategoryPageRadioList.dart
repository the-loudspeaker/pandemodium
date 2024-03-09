import 'package:flutter/material.dart';
import 'package:pandemonium/model/station.dart';
import 'package:pandemonium/model/station_data.dart';
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
              print("long press");
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
