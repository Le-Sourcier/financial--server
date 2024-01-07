import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../controllers/index.dart';
import '../../models/index.dart';
import '../index.dart';

Future<void> dataIniter() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserHiveAdapter());
  userProfile = await Hive.openBox<UserHive>('user');

  //Initialize app theme controller
  theme = Get.put(Themes());
  help.onboardingTitleColor = await help.getColors(theme);
  //Initialize the translator
  translator = Get.put(Translator());

  help = Get.put(Helps());

  // //######################### END ###########################

  //Initialized the translation data
  Get.put(Translator());
  Get.forceAppUpdate();
  var langCode = await help.readDataFromStorage("lang");
  return await translator.load(langCode: langCode.toString());
}
