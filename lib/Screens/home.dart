import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pandemonium/Screens/discover.dart';
import 'package:pandemonium/Screens/library.dart';
import 'package:pandemonium/utils/custom_fonts.dart';

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
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
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
      appBar: AppBar(
        elevation: 0,
        title: Text(
          _tabController.index==0 ? "PANDEMONIUM" : "Favourites",
          style: MontserratFont.heading3
              .copyWith(color: Theme.of(context).primaryColor),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                  color: Theme.of(context).primaryColor,
                  Platform.isIOS ? Icons.ios_share : Icons.share),
            ),
          )
        ],
      ),
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
      bottomNavigationBar: BottomNavigationBar(
        elevation: 16,
        useLegacyColorScheme: false,
        selectedLabelStyle: MontserratFont.paragraphSemiBold2,
        unselectedLabelStyle: MontserratFont.paragraphSemiBold2,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music),
            label: 'Library',
          ),
        ],
        currentIndex: _tabController.index,
        onTap: _onItemTapped,
      ),
    );
  }
}
