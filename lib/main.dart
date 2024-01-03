import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:tsomenenyo/router.dart';

import 'controllers/index.dart';
import 'helpers/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  mycolors = await PaletteGenerator.fromImageProvider(
      // const AssetImage("assets/1.png"));
      const AssetImage("assets/image2.png"));

  // country_code = Get.locale?.languageCode.toString().toLowerCase();
  countryCode = await help.readDataFromStorage("lang");

  log(countryCode.toString());

  await dataIniter().then((value) => runApp(const MyApp()));
}

late dynamic countryCode;

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Themes(),
      builder: (themes) {
        return GetMaterialApp(
          title: 'Tsomenenyo',
          debugShowCheckedModeBanner: false,
          // locale: const Locale("TG"),
          locale: Locale(countryCode.toString()),
          supportedLocales: translator.supportedLocales,
          localizationsDelegates: translator.localizationsDelegates,
          theme: themes.themeData,
          initialRoute: "/home",
          onGenerateRoute: (settings) => route(settings),
          // home: const LineChartSample2(),
        );
      },
    );
  }
}
