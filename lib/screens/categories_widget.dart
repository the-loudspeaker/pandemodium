import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pandemonium/utils/custom_fonts.dart';
import 'package:pandemonium/utils/utils.dart';

class CategoriesWidget extends StatelessWidget {
  final List<String> categoryNamesList = [
    "Science",
    "Pop",
    "Music",
    "Dance",
    "Talk",
    "Radio",
    "Rock",
    "Hits",
    "Jazz",
    "Electronic"
  ];

  CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 130.h,
          child: ScrollConfiguration(
            behavior: NoScrollGlowBehaviour(),
            child: ListView.separated(
              itemCount: categoryNamesList.length ~/ 2,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: (((index % 2) + 2) * 75).w,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(
                          width: 2,
                          color: index.isEven
                              ? Theme.of(context).colorScheme.secondary
                              : Theme.of(context).colorScheme.primary)),
                  child: Text(
                    categoryNamesList[index].toUpperCase(),
                    style: MontserratFont.paragraphSemiBold2
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(width: 8);
              },
            ),
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 110.h,
          child: ScrollConfiguration(
            behavior: NoScrollGlowBehaviour(),
            child: ListView.separated(
              itemCount:
                  categoryNamesList.length - (categoryNamesList.length ~/ 2),
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: ((((index + 1) % 2) + 2) * 70).w,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(
                          width: 2,
                          color: index.isOdd
                              ? Theme.of(context).colorScheme.secondary
                              : Theme.of(context).colorScheme.primary)),
                  child: Text(
                    categoryNamesList[index +
                            categoryNamesList.length -
                            (categoryNamesList.length ~/ 2)]
                        .toUpperCase(),
                    style: MontserratFont.paragraphSemiBold2
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(width: 8);
              },
            ),
          ),
        ),
      ],
    );
  }
}
