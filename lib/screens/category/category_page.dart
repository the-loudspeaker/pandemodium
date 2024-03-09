import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pandemonium/model/station.dart';
import 'package:pandemonium/model/station_response.dart';
import 'package:pandemonium/services/radio_service.dart';
import 'package:pandemonium/utils/custom_fonts.dart';

import 'CategoryPageRadioList.dart';

class CategoryPage extends StatefulWidget {
  final String categoryName;
  const CategoryPage({super.key, required this.categoryName});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late Future<StationResponse> futureResponse;

  void fetchCategoryRadios() async {
    var response = RadioService.getCategoryStations(widget.categoryName);
    setState(() {
      futureResponse = response;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCategoryRadios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          widget.categoryName.toUpperCase(),
          style: MontserratFont.heading3
              .copyWith(color: Theme.of(context).colorScheme.primary),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
              color: Theme.of(context).colorScheme.primary,
              Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => Future(() => fetchCategoryRadios()),
        child: FutureBuilder(
          future: futureResponse,
          builder:
              (BuildContext context, AsyncSnapshot<StationResponse> snapshot) {
            if (snapshot.hasData) {
              List<Station> categoryStationList =
                  snapshot.data?.stationList ?? [];
              return Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CategoryPageRadioList(
                          categoryStationList: categoryStationList),
                    ),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "An error occurred when fetching radio stations for this category.",
                      style: MontserratFont.paragraphReg1.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  )
                ],
              );
            } else {
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CircularProgressIndicator(),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
