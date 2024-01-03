import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:tsomenenyo/validators/user_validator.dart';

import '../controllers/index.dart';
import './components/card_color.dart';
import '../screens/index.dart';
import 'index.dart';

export 'components/server_message.dart';
export './components/alert.dart';
export './components/constantes.dart';
export './components/remote_service.dart';
export './components/theme.dart';
export './components//bool.dart';
export './auth/auth.dart';
export './components/data_initer.dart';

late PaletteGenerator mycolors;

var currentIndex = 0.obs;

void backBtn() async {
  Get.to(
    () => const HomeScreen(),
    routeName: "/home",
    transition: Transition.rightToLeftWithFade,
    id: currentIndex.value = currentIndex.value - 1,
  );
}

RxString capitalizeFirstLetter(String text) {
  if (text.isEmpty) {
    return text.obs;
  }

  return (text[0].toUpperCase() + text.substring(1)).obs;
}

List<dynamic> settingItems(BuildContext c) {
  final Themes theme = Get.put(Themes());

  return [
    {
      "label": translator.translate("LANGUAGES").value,
      "item": [
        {
          'icon': Icons.translate,
          'title': translator.translate("CHANGE_LANG").value,
          'subtitle': translator.translate("CHANGE_LANG_SUB").value,
          'color': Colors.blueAccent,
          "subTrailing": Obx(
            () {
              return help.text(
                text: capitalizeFirstLetter(translator.langCode.value).value,
                color: Colors.grey,
                size: 15,
              );
            },
          ),
          "onTap": () async {
            Get.dialog(
              CupertinoAlertDialog(
                content: Obx(
                  () {
                    return Column(
                      children: [
                        help.text(
                            text: translator.translate("CHOOSE_LANG").value,
                            color: Colors.grey),
                        ...List.generate(
                          _lanList().length,
                          (index) {
                            var lang = _lanList()[index];
                            return GetBuilder<Translator>(
                              init: Translator(),
                              builder: (c) {
                                return _langBtn(
                                  lang: lang,
                                  isSelected: lang == c.getCountryName().value,
                                );
                              },
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          },
        },
      ]
    },
    //App settings
    {
      "label": translator.translate("THEME_LABEL").value,
      "item": [
        {
          "icon": Icons.palette_outlined,
          "title": translator.translate("CARD_COLOR").value,
          "color": Colors.blueGrey,
          "subtitle": translator.translate("CARD_COLOR_SUB").value,
          "subTrailing": Container(
            height: 23.0,
            width: 23.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              gradient: LinearGradient(colors: help.cardColor),
            ),
            child: const SizedBox(),
          ),
          "onTap": () => help.customBottomSheet(
                context: c,
                body: const CardColor(),
              ),
        },
        {
          "icon":
              theme.isDark.value ? CupertinoIcons.moon : CupertinoIcons.sun_max,
          "color": theme.isDark.value ? Colors.grey : Colors.amber,
          "title": translator.translate("THEME").value,
          "subtitle": theme.isDark.value
              ? translator.translate("THEME_SUB_DARK").value
              : translator.translate("THEME_SUB_LIGHT").value,
          "trailing": Obx(
            () => CupertinoSwitch(
              value: theme.isDark.value,
              onChanged: (value) {
                theme.toggleTheme(theme);
                Get.forceAppUpdate();
              },
            ),
          ),
          'onTap': () {
            theme.toggleTheme(theme);
            Get.forceAppUpdate();
          },
        },
      ]
    },

    //Rapport and info
    {
      "label": translator.translate("RAPORT_LABEL").value,
      "item": [
        {
          "icon": CupertinoIcons.info,
          "title": translator.translate("INFO").value,
          "color": Colors.greenAccent,
        },
        {
          'icon': Icons.feedback_outlined,
          'title': translator.translate("FEEDBACK").value,
          'color': Colors.red,
          // 'onTap': () => feedBack(),
        },
        {
          "icon": CupertinoIcons.star,
          "title": translator.translate("RATE").value,
          "color": Colors.yellow,
          "onTap": rateUs
        },
        {
          'icon': Icons.bug_report,
          'title': translator.translate("RAPORT").value,
          'color': Colors.blue,
          "onTap": () => help.customBottomSheet(
                context: c,
                body: const BugRaportScreen(),
              ),
        },
      ]
    },

    {
      "label": " ",
      "item": [
        {
          "icon": CupertinoIcons.person,
          "title": translator.translate("CONTACT").value,
          "color": Colors.grey,
        },
        {
          "icon": CupertinoIcons.square_arrow_left,
          "title": translator.translate("OUT").value,
          "color": Colors.red,
        },
      ]
    }
  ];
}

List<String> _lanList() {
  List<String> frenchList = ["Français", "Anglais", "Espagnol", "Arabe"];
  List<String> englishList = ["French", "English", "Spanish", "Arabic"];
  List<String> spanishList = ["Francés", "Inglés", "Español", "Árabe"];
  List<String> arabicList = ["فرنسي", "إنجليزي", "إسباني", "عربي"];
  switch (translator.langCode.value) {
    case "fr":
      return frenchList;
    case "en":
      return englishList;
    case "es":
      return spanishList;
    case "ar":
      return arabicList;
    default:
      return frenchList;
  }
}

Widget _langBtn({
  required String lang,
  required bool isSelected,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 20.0),
    child: GestureDetector(
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 6,
            child: Padding(
              padding: EdgeInsets.all(isSelected ? 0 : 3.50),
              child: CircleAvatar(
                radius: 5.0,
                backgroundColor: isSelected ? Colors.white : Colors.blue,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: help.text(
              text: lang,
              size: 17,
            ),
          ),
          help.icon(
            icon: CupertinoIcons.forward,
            color: Colors.grey,
            size: 16,
          )
        ],
      ),
      onTap: () async {
        await translator.translateByLang(lang);
        Get.back();

        // Get.reload(key: "/login", force: true);
      },
    ),
  );
}

//Application rating function
void rateUs() {
  var userRating = 0.obs; // Track user's star rating

  Get.dialog(
    FlipInX(
      child: Obx(
        () {
          var isShow = userRating >= 2;
          return CupertinoAlertDialog(
            title: help.text(
              text: translator.translate('RATE_LABEL').value,
              color: Colors.grey,
              size: 13,
            ),
            content: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      5,
                      (index) => GestureDetector(
                        onTap: () {
                          // Update the user's star rating
                          userRating.value = index + 1;
                          // Get.back(); // Close the current dialog
                        },
                        child: help.icon(
                          icon: index < userRating.value
                              ? CupertinoIcons.star_fill
                              : CupertinoIcons.star,
                          color: index < userRating.value
                              ? Colors.amber
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                if (userRating.value == 1)
                  FadeInUp(
                      duration: const Duration(milliseconds: 300),
                      child: help.onSendButn(
                          title: translator.translate("SEND_BTN").value,
                          isValidate: true)),
                // Show the feedback form for high ratings
                showFeedbackForm(isShow)
              ],
            ),
          );
        },
      ),
    ),
  );
}

//Send us a feedback
Widget showFeedbackForm(bool isShow) {
  return AnimatedContainer(
    height: !isShow ? 0 : 230.0,
    duration: const Duration(milliseconds: 500),
    child: Column(
      children: [
        if (isShow)
          AnimatedPadding(
            duration: const Duration(milliseconds: 500),
            padding: EdgeInsets.only(top: isShow ? 20.0 : 0),
            child: CustomForm(
              controller: TextEditingController(),
              maxLines: 4,
              elevation: .5,
              textInputType: TextInputType.text,
              label: translator.translate("MESSAGE_TYPING").value,
              hintSize: 11,
            ),
          ),
        if (isShow)
          help.onSendButn(
              title: translator.translate("SEND_BTN").value, isValidate: isShow)
      ],
    ),
  );
}
