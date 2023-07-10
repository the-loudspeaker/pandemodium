import 'package:flutter/material.dart';
import 'package:pandemonium/Screens/radio_list.dart';
import 'package:pandemonium/utils/custom_fonts.dart';
import 'package:pandemonium/utils/search_dialog.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return const SearchDialog();
                });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                border: Border.all(color: Theme.of(context).primaryColor)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Add Station",
                  style: MontserratFont.paragraphMedium2.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(color: Theme.of(context).primaryColor, Icons.add),
              ],
            ),
          ),
        ),
        const Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: RadioList(),
          ),
        ),
      ],
    );
  }
}
