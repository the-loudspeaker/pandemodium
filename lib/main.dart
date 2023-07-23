import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pandemonium/Screens/home.dart';
import 'package:pandemonium/model/radio_data.dart';
import 'package:pandemonium/model/station_data.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
          child: MaterialApp(
            title: 'Pandemonium',
            debugShowCheckedModeBanner: false,
            color: Theme.of(context).primaryColor,
            theme: ThemeData(useMaterial3: true),
            home: const MyHomePage(),
          ),
        );
      },
    );
  }
}
