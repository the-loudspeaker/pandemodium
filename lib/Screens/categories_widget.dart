import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pandemonium/utils/custom_colors.dart';
import 'package:pandemonium/utils/custom_fonts.dart';
import 'package:pandemonium/utils/no_scrollglow_behaviour.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key});

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  @override
  void initState() {
    // TODO: implement initState
    // TODO: fetch Categories
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: ScreenUtil().setHeight(100),
          child: ScrollConfiguration(
            behavior: NoScrollGlowBehaviour(),
            child: ListView.separated(
              itemCount: 40,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: ScreenUtil().setWidth(150),
                  height: ScreenUtil().setHeight(50),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(
                          color: index.isEven
                              ? CustomColors.secondaryGrey
                              : Colors.black)),
                  child: Text(
                    "Science".toUpperCase(),
                    style: MontserratFont.paragraphSemiBold2
                        .copyWith(color: CustomColors.secondaryGrey),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  width: 8,
                );
              },
            ),
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(16),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(100),
          child: ScrollConfiguration(
            behavior: NoScrollGlowBehaviour(),
            child: ListView.separated(
              itemCount: 40,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: ScreenUtil().setWidth(180),
                  height: ScreenUtil().setHeight(50),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(
                          color: index.isOdd ? CustomColors.secondaryGrey : Colors.black)),
                  child: Text(
                    "History".toUpperCase(),
                    style: MontserratFont.paragraphSemiBold2
                        .copyWith(color: CustomColors.secondaryGrey),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  width: 8,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
