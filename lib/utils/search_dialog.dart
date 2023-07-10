import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pandemonium/Services/radio_service.dart';
import 'package:pandemonium/model/radio_data.dart';
import 'package:pandemonium/model/station.dart';
import 'package:provider/provider.dart';

import 'custom_fonts.dart';

class SearchDialog extends StatefulWidget {
  const SearchDialog({
    super.key,
  });

  @override
  State<SearchDialog> createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  final TextEditingController _textEditingController = TextEditingController();
  List<Station> searchedStations = [];
  bool showLoader = false;

  @override
  initState() {
    _textEditingController.addListener(onTextChange);
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void onTextChange() async {
    if (_textEditingController.text.length >= 3) {
      setState(() {
        showLoader = true;
      });
      await RadioService.searchRadios(_textEditingController.text)
          .then((value) {
        setState(() {
          searchedStations = value.stationList!;
          showLoader = false;
        });
      });
    } else {
      setState(() {
        searchedStations = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Search",
        style: MontserratFont.paragraphMedium1
            .copyWith(color: Theme.of(context).primaryColor),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 24),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: Text("Cancel", style: MontserratFont.paragraphMedium2)),
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                Icons.search,
                color: Theme.of(context).primaryColor,
              ),
              Expanded(
                child: TextField(
                  controller: _textEditingController,
                  style: MontserratFont.paragraphMedium1,
                  strutStyle:
                      StrutStyle.fromTextStyle(MontserratFont.paragraphMedium1),
                  autofocus: false,
                ),
              ),
            ],
          ),
          showLoader
              ? Padding(
                  padding: EdgeInsets.only(top: ScreenUtil().setHeight(16)),
                  child: const CircularProgressIndicator(),
                )
              : searchedStations.isNotEmpty
                  ? Container(
                      padding: EdgeInsets.only(top: ScreenUtil().setHeight(8)),
                      width: double.maxFinite,
                      height: ScreenUtil().setHeight(180),
                      child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: ((context, index) {
                            return InkWell(
                              splashColor: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                              onTap: () {
                                Provider.of<RadioData>(context, listen: false)
                                    .addStation(searchedStations[index]);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    searchedStations[index].name!,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    searchedStations[index].homepage!,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            );
                          }),
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider();
                          },
                          itemCount: searchedStations.length),
                    )
                  : Container()
        ],
      ),
    );
  }
}
