import 'package:flutter/material.dart';
import 'package:pandemonium/Screens/discover.dart';
import 'package:pandemonium/Screens/library.dart';
import 'package:pandemonium/Services/playback_service.dart';
import 'package:pandemonium/model/station_data.dart';
import 'package:pandemonium/utils/custom_fonts.dart';
import 'package:pandemonium/utils/media_player_bottom_sheet.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    PlayBackService.initBackgroundAudioService();
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    Provider.of<StationData>(context, listen: false).endRadio();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _tabController.animateTo(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      primary: false,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: const [
            Discover(),
            LibraryScreen(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      bottomSheet: mediaPlayerBottomSheet(context),
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
          icon: _tabController.index == 0
              ? const Icon(Icons.home)
              : const Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: _tabController.index == 1
              ? const Icon(Icons.library_music)
              : const Icon(Icons.library_music_outlined),
          label: 'Library',
        ),
      ],
      currentIndex: _tabController.index,
      onTap: _onItemTapped,
    );
  }
}
