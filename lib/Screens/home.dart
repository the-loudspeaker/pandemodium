import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pandemonium/Screens/discover.dart';
import 'package:pandemonium/Screens/library.dart';
import 'package:pandemonium/model/station_data.dart';
import 'package:pandemonium/utils/custom_fonts.dart';
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
      bottomSheet: _bottomSheetBuilder(context),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
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
    );
  }
}

GestureDetector? _bottomSheetBuilder(BuildContext context) {
  return Provider.of<StationData>(context).currentState != MediaStates.end
      ? GestureDetector(
          onVerticalDragUpdate: (verticalDragUpdate) {
            if (verticalDragUpdate.delta.dy > 1.5 &&
                Provider.of<StationData>(context, listen: false).currentState !=
                    MediaStates.end) {
              Provider.of<StationData>(context, listen: false).endRadio();
            }
          },
          child: Container(
            height: 64.h,
            color: Theme.of(context).scaffoldBackgroundColor,
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Provider.of<StationData>(context)
                                .selectedStation
                                .name
                                ?.toUpperCase() ??
                            "",
                        style: MontserratFont.paragraphSemiBold1
                            .copyWith(color: Theme.of(context).primaryColor),
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                          Provider.of<StationData>(context)
                                  .selectedStation
                                  .homepage
                                  ?.toUpperCase() ??
                              "",
                          style: MontserratFont.captionMedium.copyWith(
                              color: Theme.of(context).colorScheme.secondary),
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis)
                    ],
                  ),
                ),
                _mediaIconWidget(context),
              ],
            ),
          ),
        )
      : null;
}

Widget _mediaIconWidget(BuildContext context) {
  switch (Provider.of<StationData>(context).currentState) {
    case MediaStates.play:
      return IconButton(
        onPressed: () {
          Provider.of<StationData>(context, listen: false).stopRadio();
        },
        icon: Icon(color: Theme.of(context).primaryColor, Icons.stop),
      );
    case MediaStates.loading:
      return IconButton(
        icon:
            Icon(Icons.circle_outlined, color: Theme.of(context).primaryColor),
        onPressed: null,
      );
    default:
      return IconButton(
        icon: Icon(color: Theme.of(context).primaryColor, Icons.play_arrow),
        onPressed: () {
          Provider.of<StationData>(context, listen: false).playRadio(
              Provider.of<StationData>(context, listen: false).selectedStation);
        },
      );
  }
}
