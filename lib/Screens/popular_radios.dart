import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pandemonium/Services/radio_service.dart';
import 'package:pandemonium/model/station_response.dart';
import 'package:pandemonium/utils/custom_colors.dart';
import 'package:pandemonium/utils/custom_fonts.dart';

class PopularRadios extends StatefulWidget {
  const PopularRadios({
    super.key,
  });

  @override
  State<PopularRadios> createState() => _PopularRadiosState();
}

class _PopularRadiosState extends State<PopularRadios> with AutomaticKeepAliveClientMixin<PopularRadios> {
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
    return FutureBuilder(
      future: popularRadiosList,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            padding: const EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: CustomColors.primaryGrey,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24), topRight: Radius.circular(24)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Popular Radios".toUpperCase(),
                  style: MontserratFont.heading4
                      .copyWith(color: FontColors.primaryTextColor),
                ),
                ListView.separated(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.stationList!.length,
                  itemBuilder: (context, index) {
                    bool isFaviconEmpty =
                        snapshot.data?.stationList![index].favicon!.isEmpty ??
                            true;
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: ScreenUtil().setHeight(8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          isFaviconEmpty
                              ? const Icon(
                                  Icons.radio,
                                  size: 32,
                                )
                              : Image.network(
                                  height: 32,
                                  width: 32,
                                  // fit: BoxFit.cover,
                                  snapshot.data?.stationList![index].favicon ??
                                      "https://placehold.jp/32x32.png"),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data!.stationList![index].name
                                          ?.toUpperCase() ??
                                      "",
                                  style: MontserratFont.paragraphSemiBold1
                                      .copyWith(
                                          color: FontColors.primaryTextColor),
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                    snapshot.data!.stationList![index].homepage
                                            ?.toUpperCase() ??
                                        "",
                                    style: MontserratFont.captionMedium
                                        .copyWith(
                                            color: FontColors.primaryTextColor),
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis)
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: FontColors.primaryTextColor,
                                width: 1.0,
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                // Navigator.push(context, MaterialPageRoute(builder: (context){
                                //   return const MyNewHomePage();
                                // }));
                              },
                              child: CircleAvatar(
                                radius: ScreenUtil().setHeight(16),
                                backgroundColor: CustomColors.primaryGrey,
                                foregroundColor: Colors.black,
                                child: const Icon(Icons.play_arrow),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      thickness: 2,
                      color: Colors.white,
                    );
                  },
                )
              ],
            ),
          );
        }
        if (snapshot.hasError) {
          return const Text("Error");
        }
        return Center(
          child: CircularProgressIndicator(
            color: FontColors.primaryTextColor,
          ),
        );
      },
    );
  }

  Future<StationResponse> fetchPopularRadios() async {
    return RadioService.getPopularStations();
  }
}
