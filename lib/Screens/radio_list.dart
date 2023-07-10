import 'package:flutter/material.dart';
import 'package:pandemonium/utils/radio_list_builder.dart';
import 'package:provider/provider.dart';
import 'package:pandemonium/model/radio_data.dart';

class RadioList extends StatelessWidget {
  const RadioList({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<RadioData>(context).getData();
    return ListView.separated(
        itemBuilder: (context, index) {
          return RadioListBuilder(
            stationList: Provider.of<RadioData>(context).stationSet.toList(),
            index: index,
            callback: () {
              Provider.of<RadioData>(context, listen: false).removeStation(
                  Provider.of<RadioData>(context, listen: false)
                      .stationSet
                      .toList()[index]);
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
        itemCount: Provider.of<RadioData>(context).stationSet.length);
  }
}
