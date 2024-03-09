import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pandemonium/model/radio_data.dart';
import 'package:pandemonium/model/station.dart';
import 'package:pandemonium/services/radio_service.dart';
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
        if (mounted) {
          setState(() {
            searchedStations = value.stationList!;
            showLoader = false;
          });
        }
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
            .copyWith(color: Theme.of(context).colorScheme.primary),
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
                color: Theme.of(context).colorScheme.primary,
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
                  padding: EdgeInsets.only(top: 16.h),
                  child: const CircularProgressIndicator(),
                )
              : searchedStations.isNotEmpty
                  ? Container(
                      padding: EdgeInsets.only(top: 8.h),
                      width: double.maxFinite,
                      height: 180.h,
                      child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: ((context, index) {
                            return InkWell(
                              splashColor:
                                  Theme.of(context).colorScheme.secondary,
                              onTap: () {
                                bool wasStationAdded = Provider.of<RadioData>(
                                        context,
                                        listen: false)
                                    .addStation(searchedStations[index]);
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
                                Navigator.pop(context, 'Ok');
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
                            return Divider(
                                color: Theme.of(context).dividerColor);
                          },
                          itemCount: searchedStations.length),
                    )
                  : Container()
        ],
      ),
    );
  }
}
