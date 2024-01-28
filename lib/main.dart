import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pandemonium/model/radio_data.dart';
import 'package:pandemonium/model/station_data.dart';
import 'package:provider/provider.dart';

import 'screens/discover.dart';
import 'screens/library.dart';
import 'utils/bottom_sheet_and_navbar.dart';

void main() {
  runApp(const MyApp());
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
final GoRouter _router = GoRouter(
  initialLocation: "/",
  navigatorKey: _rootNavigatorKey,
  routes: <RouteBase>[
    ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          print(state.matchedLocation);
          return ScaffoldBottomSheetAndNavBar(
            child: child,
          );
        },
        routes: [
          GoRoute(
              path: '/',
              parentNavigatorKey: _shellNavigatorKey,
              routes: <RouteBase>[
                GoRoute(
                    path: 'library',
                    parentNavigatorKey: _shellNavigatorKey,
                    builder: (BuildContext context, GoRouterState state) {
                      return const LibraryScreen();
                    })
              ],
              builder: (BuildContext context, GoRouterState state) {
                return const Discover();
              }),
        ]),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (BuildContext context, Widget? child) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (context) => RadioData()),
                ChangeNotifierProvider(create: (context) => StationData())
              ],
              child: MaterialApp.router(
                title: 'Pandemonium',
                debugShowCheckedModeBanner: false,
                color: Theme.of(context).colorScheme.primary,
                theme: ThemeData(
                    colorScheme: lightDynamic,
                    fontFamily: "Monsterrat",
                    useMaterial3: true),
                routerConfig: _router,
              ),
            );
          },
        );
      },
    );
  }
}
