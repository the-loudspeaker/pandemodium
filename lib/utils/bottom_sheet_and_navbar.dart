import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pandemonium/model/station_data.dart';
import 'package:pandemonium/services/playback_service.dart';
import 'package:provider/provider.dart';

import 'custom_fonts.dart';
import 'media_player_bottom_sheet.dart';

class ScaffoldBottomSheetAndNavBar extends StatefulWidget {
  final Widget child;

  const ScaffoldBottomSheetAndNavBar({super.key, required this.child});

  @override
  State<ScaffoldBottomSheetAndNavBar> createState() =>
      _ScaffoldBottomSheetAndNavBarState();
}

class _ScaffoldBottomSheetAndNavBarState
    extends State<ScaffoldBottomSheetAndNavBar> {
  late GoRouter router;

  @override
  void initState() {
    PlayBackService.initBackgroundAudioService();
    router = GoRouter.of(context);
    super.initState();
  }

  @override
  void dispose() {
    Provider.of<StationData>(context, listen: false).stopRadio();
    Provider.of<StationData>(context, listen: false).destroyRadio();
    Provider.of<StationData>(context, listen: false).dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if ((index == 0 &&
            router.routeInformationProvider.value.uri.toString() == "/") ||
        (index == 1 &&
            router.routeInformationProvider.value.uri.toString() ==
                "/library")) {
      return;
    }
    if (router.routeInformationProvider.value.uri.toString() == "/") {
      router.go("/library");
      return;
    }
    if (router.routeInformationProvider.value.uri.toString() == "/library") {
      router.go("/");
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: widget.child),
      bottomSheet: mediaPlayerBottomSheet(context),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      elevation: 16,
      useLegacyColorScheme: false,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Theme.of(context).colorScheme.secondary,
      selectedLabelStyle: MontserratFont.paragraphSemiBold2,
      unselectedLabelStyle: MontserratFont.paragraphSemiBold2,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: router.routeInformationProvider.value.uri.toString() == "/"
              ? const Icon(Icons.home)
              : const Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon:
              router.routeInformationProvider.value.uri.toString() == "/library"
                  ? const Icon(Icons.library_music)
                  : const Icon(Icons.library_music_outlined),
          label: 'Library',
        ),
      ],
      onTap: _onItemTapped,
    );
  }
}
