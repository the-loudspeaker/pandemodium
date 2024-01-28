import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pandemonium/utils/custom_fonts.dart';
import 'package:pandemonium/utils/search_dialog.dart';

import 'fav_radio_list.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GoRouter router = GoRouter.of(context);
    return WillPopScope(
      onWillPop: () async {
        router.go("/");
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Favourites",
            style: MontserratFont.heading3
                .copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          automaticallyImplyLeading: false,
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
                    border: Border.all(
                        color: Theme.of(context).colorScheme.primary)),
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
                    Icon(
                        color: Theme.of(context).colorScheme.primary,
                        Icons.add),
                  ],
                ),
              ),
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: FavRadioListWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
