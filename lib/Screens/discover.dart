import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pandemonium/Screens/categories_widget.dart';
import 'package:pandemonium/Services/radio_service.dart';
import 'package:pandemonium/model/radio_data.dart';
import 'package:pandemonium/model/station_response.dart';
import 'package:pandemonium/utils/custom_fonts.dart';
import 'package:pandemonium/utils/radio_list_builder.dart';
import 'package:provider/provider.dart';

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
    popularRadiosList = fetchPopularRadios();
    super.initState();
  }

  @override
  bool get wantKeepAlive => false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      primary: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                return Container(
                    padding: const EdgeInsets.all(16),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
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
                          style: MontserratFont.heading4
                              .copyWith(color: Theme.of(context).primaryColor),
                        ),
                        ListView.separated(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.stationList!.length,
                          itemBuilder: (context, index) {
                            return RadioListBuilder(
                              stationList: snapshot.data!.stationList!,
                              index: index,
                              longPressCallback: () {
                                bool wasStationAdded = Provider.of<RadioData>(
                                        context,
                                        listen: false)
                                    .addStation(
                                        snapshot.data!.stationList![index]);
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  showCloseIcon: true,
                                  closeIconColor: Theme.of(context)
                                      .snackBarTheme
                                      .closeIconColor,
                                  margin: EdgeInsets.symmetric(
                                      vertical: ScreenUtil().setHeight(64),
                                      horizontal: ScreenUtil().setHeight(16)),
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
                              onTapCallback: (){
                                debugPrint("Clicked on a station ${snapshot.data!.stationList![index].name}");
                              },
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider();
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
                              color: Theme.of(context).primaryColor)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Error loading popular radios. Retry",
                            style: MontserratFont.paragraphMedium2.copyWith(
                              color: Theme.of(context).primaryColor,
                            ),
                            softWrap: true,
                          ),
                          const SizedBox(width: 4),
                          Icon(
                              color: Theme.of(context).primaryColor,
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
    );
  }

  Future<StationResponse> fetchPopularRadios() async {
    return RadioService.getPopularStations();
  }
}
