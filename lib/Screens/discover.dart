import 'package:flutter/material.dart';
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
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      color: Theme.of(context).primaryColor,
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      onRefresh: () {
        setState(() {
          popularRadiosList = fetchPopularRadios();
        });
        return Future(() => null);
      },
      child: FutureBuilder(
          future: popularRadiosList,
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Text(
                          "Categories".toUpperCase(),
                          style: MontserratFont.heading4.copyWith(
                              color: Theme.of(context).colorScheme.primary),
                        )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: CategoriesWidget(),
                    ),
                    Container(
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
                            style: MontserratFont.heading4.copyWith(
                                color: Theme.of(context).primaryColor),
                          ),
                          ListView.separated(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.stationList!.length,
                            itemBuilder: (context, index) {
                              return RadioListBuilder(
                                stationList: snapshot.data!.stationList!,
                                index: index,
                                callback: () {
                                  Provider.of<RadioData>(context, listen: false)
                                      .addStation(
                                          snapshot.data!.stationList![index]);
                                },
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const Divider();
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            if (snapshot.hasError) {
              return const Text("Error");
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  Future<StationResponse> fetchPopularRadios() async {
    return RadioService.getPopularStations();
  }
}
