import 'package:flutter/material.dart';
import 'package:pandemonium/Screens/categories_widget.dart';
import 'package:pandemonium/Screens/popular_radios.dart';
import 'package:pandemonium/utils/custom_fonts.dart';

class Discover extends StatelessWidget {
  const Discover({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
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
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: CategoriesWidget(),
            ),
            const PopularRadios(),
          ],
        ),
      ),
    );
  }
}
