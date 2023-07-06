import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pandemonium/Screens/categories_widget.dart';
import 'package:pandemonium/Screens/popular_radios.dart';
import 'package:pandemonium/utils/custom_fonts.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(onTap: () {}, child: const Icon(Icons.menu)),
        actions: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(Platform.isIOS ? Icons.ios_share : Icons.share),
            ),
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  "Categories".toUpperCase(),
                  style: MontserratFont.heading4
                      .copyWith(color: FontColors.primaryTextColor),
                )),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: CategoriesWidget(),
            ),
            const PopularRadios()
          ],
        ),
      ),
    );
  }
}
