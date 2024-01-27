import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pandemonium/Screens/discover.dart';
import 'package:pandemonium/Screens/library.dart';
import 'package:pandemonium/model/radio_data.dart';
import 'package:pandemonium/model/station_data.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const Discover();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'library',
          builder: (BuildContext context, GoRouterState state) {
            return const LibraryScreen();
          },
        ),
      ],
    ),
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
