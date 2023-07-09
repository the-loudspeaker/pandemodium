import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pandemonium/Screens/discover_screen.dart';
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
    _tabController = TabController(length: 3, vsync: this);
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
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "PANDEMONIUM",
          style: MontserratFont.heading3,
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(Platform.isIOS ? Icons.ios_share : Icons.share),
            ),
          )
        ],
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: const [
          Discover(),
          Center(child: Text("Page 2")),
          Center(
            child: Text("Page 3"),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white.withOpacity(0.8),
        elevation: 16,
        selectedLabelStyle: MontserratFont.paragraphSemiBold2
            .copyWith(color: FontColors.primaryTextColor),
        unselectedLabelStyle: MontserratFont.captionSemiBold
            .copyWith(color: FontColors.secondaryTextColor),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
        currentIndex: _tabController.index,
        selectedItemColor: FontColors.primaryTextColor,
        unselectedItemColor: FontColors.secondaryTextColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
