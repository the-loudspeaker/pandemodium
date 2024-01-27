import 'package:flutter/material.dart';
import 'package:pandemonium/utils/custom_fonts.dart';
import 'package:pandemonium/utils/search_dialog.dart';

import 'radio_list.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Favourites",
          style: MontserratFont.heading3
              .copyWith(color: Theme.of(context).colorScheme.primary),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: IconButton(
              onPressed: () {
                showAdaptiveDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        alignment: Alignment.center,
                        elevation: 1,
                        contentPadding: const EdgeInsets.all(24),
                        children: [
                          Text(
                              "Long press a station to add / remove from favorites.",
                              style: MontserratFont.paragraphMedium2.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ))
                        ],
                      );
                    });
              },
              icon: Icon(Icons.help,
                  color: Theme.of(context).colorScheme.primary),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              showAdaptiveDialog(
                  context: context,
                  builder: (context) {
                    return const SearchDialog();
                  });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  border:
                      Border.all(color: Theme.of(context).colorScheme.primary)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Add Station",
                    style: MontserratFont.paragraphMedium2.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(color: Theme.of(context).colorScheme.primary, Icons.add),
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
      ),
    );
  }
}
