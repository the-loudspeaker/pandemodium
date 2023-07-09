import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pandemonium/utils/custom_fonts.dart';
import 'package:pandemonium/utils/no_scrollglow_behaviour.dart';

class CategoriesWidget extends StatelessWidget {
  final List<String> stationNames = ["Science","Pop","Music", "Dance", "Talk", "Radio", "Rock", "Hits", "Jazz", "Electronic"];
  CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: ScreenUtil().setHeight(130),
          child: ScrollConfiguration(
            behavior: NoScrollGlowBehaviour(),
            child: ListView.separated(
              itemCount: stationNames.length~/2,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: ScreenUtil().setWidth(((index % 2) + 2) * 75),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(
                        width: 2,
                          color: index.isEven
                              ? FontColors.secondaryTextColor
                              : FontColors.primaryTextColor)),
                  child: Text(
                    stationNames[index].toUpperCase(),
                    style: MontserratFont.paragraphSemiBold2
                        .copyWith(color: FontColors.secondaryTextColor),
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
          height: ScreenUtil().setHeight(110),
          child: ScrollConfiguration(
            behavior: NoScrollGlowBehaviour(),
            child: ListView.separated(
              itemCount: stationNames.length-(stationNames.length~/2),
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: ScreenUtil().setWidth((((index+1) % 2) + 2) * 70),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(
                          width: 2,
                          color: index.isOdd
                              ? FontColors.secondaryTextColor
                              : FontColors.primaryTextColor)),
                  child: Text(
                    stationNames[index+stationNames.length-(stationNames.length~/2)].toUpperCase(),
                    style: MontserratFont.paragraphSemiBold2
                        .copyWith(color: FontColors.secondaryTextColor),
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
