import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import '../../helpers/index.dart';

// Initialize and use GetX for state management
late Translator translator;

class Translator extends GetxController {
  // Define supported locales for the app
  final Iterable<Locale> supportedLocales = const <Locale>[
    Locale('en', 'US'),
    Locale('fr', 'FR')
  ];

  // Localizations delegates used for translation
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate, // Here !
    DefaultWidgetsLocalizations.delegate,
  ];

  // RxString for reactive language code
  late RxString langCode = "fr".obs; // Initialize with a default value

  // Map to store localized strings
  Map<String, String> _localizedStrings = {};

  // Static method to get the Translator instance from a BuildContext
  static Translator? of(BuildContext context) {
    return Localizations.of<Translator>(context, Translator);
  }

  // Load localized strings from JSON files based on the language code
  Future<void> load({required String langCode}) async {
    try {
      // Load translation file based on the provided language code
      String jsonContent =
          await rootBundle.loadString('assets/languages/$langCode.json');

      Map<String, dynamic> jsonMap = json.decode(jsonContent);
      _localizedStrings =
          jsonMap.map((key, value) => MapEntry(key, value.toString()));
    } catch (e) {
      log(e.toString());
      // In case of loading error, load the default language
      String defaultJsonContent =
          await rootBundle.loadString('assets/languages/fr.json');
      Map<String, dynamic> defaultJsonMap = json.decode(defaultJsonContent);
      _localizedStrings =
          defaultJsonMap.map((key, value) => MapEntry(key, value.toString()));
    }
  }

  // Translate a key to a reactive string
  Rx<String> translate(String key) {
    return RxString(_localizedStrings[key] ?? key);
  }

  // Translate the application by the provided language
  Future<void> translateByLang(String language) async {
    String langCode;

    switch (language) {
      case "الفرنسية":
      case "French":
      case "Francés":
      case "Français":
        langCode = "fr";
        break;
      case "الإسبانية":
      case "Spanish":
      case "Español":
      case "Espagnol":
        langCode = "es";
        break;
      case "الإنجليزية":
      case "English":
      case "Inglés":
      case "Anglais":
        langCode = "en";
        break;
      case "عربي":
      case "Arabic":
      case "Árabe":
      case "Arabe":
        langCode = "ar";
        break;
      default:
        langCode = "fr"; // Default language is French if not recognized.
    }

    // Write the selected language code to storage
    await help.writeDataToStorage("lang", langCode);
    var loadData = await load(langCode: langCode);

    // Force the app to update to reflect the new language
    Get.forceAppUpdate();

    return loadData;
  }

  // Get the country name based on the current language code
  // RxString getCountryName() {
  //   switch (langCode.value) {
  //     case "fr":
  //       return "Français".obs;
  //     case "en":
  //       return "English".obs;
  //     case "es":
  //       return "Espagnol".obs;
  //     default:
  //       return "Français".obs;
  //   }
  // }
  RxString getCountryName() {
    List<String> frenchList = ["Français", "Anglais", "Espagnol", "Arabe"];
    List<String> englishList = ["French", "English", "Spanish", "Arabic"];
    List<String> spanishList = ["Francés", "Inglés", "Español", "Árabe"];
    List<String> arabicList = ["فرنسي", "إنجليزي", "إسباني", "عربي"];

    switch (langCode.value) {
      case "fr":
        if (langCode.value == "fr") {
          return frenchList[0].obs;
        } else if (langCode.value == "en") {
          return frenchList[1].obs;
        } else if (langCode.value == "es") {
          return frenchList[2].obs;
        } else if (langCode.value == "ar") {
          return frenchList[3].obs;
        } else {
          return frenchList[0].obs;
        }

      case "en":
        if (langCode.value == "fr") {
          return englishList[0].obs;
        } else if (langCode.value == "en") {
          return englishList[1].obs;
        } else if (langCode.value == "es") {
          return englishList[2].obs;
        } else if (langCode.value == "ar") {
          return englishList[3].obs;
        } else {
          return englishList[0].obs;
        }

      case "es":
        if (langCode.value == "fr") {
          return spanishList[0].obs;
        } else if (langCode.value == "en") {
          return spanishList[1].obs;
        } else if (langCode.value == "es") {
          return spanishList[2].obs;
        } else if (langCode.value == "ar") {
          return spanishList[3].obs;
        } else {
          return spanishList[0].obs;
        }

      case "ar":
        if (langCode.value == "fr") {
          return arabicList[0].obs;
        } else if (langCode.value == "en") {
          return arabicList[1].obs;
        } else if (langCode.value == "es") {
          return arabicList[2].obs;
        } else if (langCode.value == "ar") {
          return arabicList[3].obs;
        } else {
          return arabicList[0].obs;
        }
      default:
        return frenchList[0].obs;
    }
  }

  @override
  void onInit() async {
    // Read the stored language code from storage and assign it to langCode
    final storedLangCode = await help.readDataFromStorage("lang");

    // Check if the value is not empty before assigning it
    if (storedLangCode != null && storedLangCode.isNotEmpty) {
      langCode.value = storedLangCode.toString();
      Get.forceAppUpdate();
    }

    super.onInit();
  }
}
