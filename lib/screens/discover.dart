import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pandemonium/model/radio_data.dart';
import 'package:pandemonium/model/station.dart';
import 'package:pandemonium/model/station_data.dart';
import 'package:pandemonium/model/station_response.dart';
import 'package:pandemonium/services/radio_service.dart';
import 'package:pandemonium/utils/custom_fonts.dart';
import 'package:pandemonium/utils/radio_list_builder.dart';
import 'package:provider/provider.dart';

import 'categories_widget.dart';

class Discover extends StatefulWidget {
  const Discover({
    super.key,
  });

  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover>
    with AutomaticKeepAliveClientMixin<Discover> {
  late Future<StationResponse> popularRadiosList;

  @override
  void initState() {
    RadioService.dnsLookup();
    popularRadiosList = fetchPopularRadios();
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    Provider.of<RadioData>(context, listen: false).getData();
    Provider.of<StationData>(context, listen: false).getLastPlayed();
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("PANDEMONIUM",
          style: MontserratFont.heading3
              .copyWith(color: Theme.of(context).colorScheme.primary),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: IconButton(
              onPressed: () {},
              icon:Icon(
                  color: Theme.of(context).colorScheme.primary,
                  Platform.isIOS ? Icons.ios_share : Icons.share),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        primary: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
                padding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Text(
                  "Categories".toUpperCase(),
                  style: MontserratFont.heading4
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: CategoriesWidget(),
            ),
            FutureBuilder(
              future: popularRadiosList,
              builder: (BuildContext context,
                  AsyncSnapshot<StationResponse> snapshot) {
                if (snapshot.hasData) {
                  List<Station> givenStations = snapshot.data!.stationList!;
                  return Container(
                      padding: const EdgeInsets.all(16),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Popular Radios".toUpperCase(),
                            style: MontserratFont.heading4.copyWith(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          ListView.separated(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: givenStations.length,
                            itemBuilder: (context, index) {
                              return RadioListBuilder(
                                stationList: givenStations,
                                index: index,
                                longPressCallback: () {
                                  bool wasStationAdded = Provider.of<RadioData>(
                                      context,
                                      listen: false)
                                      .addStation(
                                      givenStations[index]);
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
                                onTapCallback: () {
                                  debugPrint(
                                      "Clicked on a station ${givenStations[index].name}");
                                  Provider.of<StationData>(context,
                                      listen: false)
                                      .playRadio(
                                      givenStations[index]);
                                },
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Divider(
                                color: Theme.of(context).dividerColor,
                              );
                            },
                          )
                        ],
                      ));
                }
                if (snapshot.hasError) {
                  debugPrint(snapshot.error.toString());
                  return Center(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          popularRadiosList = fetchPopularRadios();
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                            border: Border.all(
                                color: Theme.of(context).colorScheme.primary)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Error loading popular radios. Retry",
                              style: MontserratFont.paragraphMedium2.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              softWrap: true,
                            ),
                            const SizedBox(width: 4),
                            Icon(
                                color: Theme.of(context).colorScheme.primary,
                                Icons.refresh),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<StationResponse> fetchPopularRadios() async {
    return RadioService.getPopularStations();
  }
}
