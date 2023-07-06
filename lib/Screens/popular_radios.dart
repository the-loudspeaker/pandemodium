import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pandemonium/utils/custom_colors.dart';
import 'package:pandemonium/utils/custom_fonts.dart';

class PopularRadios extends StatelessWidget {
  const PopularRadios({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: ScreenUtil().setHeight(280),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: CustomColors.primaryGrey,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24)),
      ),
      child: Text(
        "Popular Radios".toUpperCase(),
        style: MontserratFont.heading4,
      ),
    );
  }
}
