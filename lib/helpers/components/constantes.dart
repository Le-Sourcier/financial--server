import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:badges/badges.dart' as badges;
import 'package:image_picker/image_picker.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tsomenenyo/helpers/index.dart';
import 'package:universal_html/html.dart' as html;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../controllers/index.dart';

Helps help = Get.put(Helps());

class Helps extends GetxController {
  //Get phone number dial code
  var dialCode = "".obs;
  late Color appColorDark;
  late List<Color> cardColor;

  var isoCode = "".obs;

  //Image picker
  Rx<XFile?> selectedImage = Rx<XFile?>(null);

  //Image picker for web platform init
  Rx<Uint8List?> selectedImageForWeb = Rx<Uint8List?>(null);
  XFile? image;

  var color = const Color.fromARGB(255, 3, 56, 100);

  //Get current user country code
  var country = "".obs;
  late FlutterSecureStorage storage;

  ///Custom text widget
  Text text({
    required final String text,
    Color? color,
    FontWeight? fontWeight,
    double? size,
    FontStyle? fontStyle,
    String? fontFamily,
    TextOverflow? overflow,
    bool islineThrough = false,
    TextAlign? align,
    int? maxLines,
    TextStyle? style,
    TextDirection? textDirection,
    Color? decorationColor,
    double? decorationThickness,
    TextDecorationStyle? decorationStyle,
  }) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: align,
      textDirection: textDirection,
      style: style ??
          TextStyle(
            color: color,
            decorationColor:
                decorationColor ?? (islineThrough ? Colors.red : null),
            decorationThickness:
                decorationThickness ?? (islineThrough ? 2 : null),
            decorationStyle: decorationStyle,
            fontSize: size,
            fontWeight: fontWeight,
            fontStyle: fontStyle,
            fontFamily: fontFamily,
            overflow: overflow,
            decoration: islineThrough
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
    );
  }

  //######################## Custom icon widget ########################
  Widget icon({
    required IconData icon,
    void Function()? onTap,
    double? size,
    Color? color,
    TextDirection? diction,
    bool showBadge = false,
    Color? backgroundColor,
    BadgeStyle? badgeStyle,
    Widget? badgeContent,
    BadgePosition? badgePosition,
    Color? badgeBorderSideColor,
    double? radius,
  }) {
    Get.theme;
    if (showBadge) {
      return GestureDetector(
        onTap: onTap,
        child: CircleAvatar(
          radius: radius,
          backgroundColor:
              backgroundColor ?? Get.theme.cardColor.withOpacity(.7),
          child: badges.Badge(
            showBadge: showBadge,
            badgeContent: badgeContent,
            position:
                badgePosition ?? badges.BadgePosition.topEnd(top: 2, end: 2),
            ignorePointer: true,
            badgeStyle: badgeStyle ??
                badges.BadgeStyle(
                  borderSide: BorderSide(
                    width: 1.2,
                    color: badgeBorderSideColor ??
                        Get.theme.cardColor.withOpacity(.7),
                  ),
                ),
            child: Icon(icon, size: size, color: color, textDirection: diction),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: onTap,
        child: Icon(icon, size: size, color: color, textDirection: diction),
      );
    }
  }

  Widget onSendButn({
    final bool isValidate = false,
    required String title,
    Color? backgroundColor,
    double? titleSize,
    FontWeight? fontWeight,
    Color? color,
    TextOverflow? overflow,
  }) {
    var valid = false.obs;
    return Obx(
      () {
        valid.value = isValidate;
        return Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Card(
              elevation: !valid.value ? 0.3 : null,
              color: !valid.value
                  ? null
                  : backgroundColor ?? help.appColorDark.withOpacity(0.4),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                enableFeedback: false,
                onTap: !valid.value ? null : () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 10),
                  child: help.text(
                    text: title,
                    color: valid.value ? color : color ?? Colors.grey,
                    size: titleSize,
                    fontWeight: fontWeight,
                    overflow: overflow,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  //######################## Storage management with shared Pref ########################
  /// Function to write data to SharedPreferences
  Future<void> writeDataToStorage(String key, dynamic value) async {
    if (kIsWeb) {
      return html.window.localStorage[key] = value;
    } else {
      return await storage.write(key: key, value: value.toString());
    }
  }

  //######################## Function to read data from SharedPreferences ########################
  Future<String?> readDataFromStorage(String key) async {
    if (kIsWeb) {
      return html.window.localStorage[key];
    } else {
      return await storage.read(key: key).catchError((error) => error);
    }
  }

  //######################## Function to remove data from SharedPreferences ########################
  Future<dynamic> removeDataFromStorage(String key) async {
    if (kIsWeb) {
      return html.window.localStorage.remove(key);
    } else {
      return await storage.delete(key: key);
    }
  }

  //######################## Build a void loading function ########################
  Function loading(bool isLoading, {bool isblur = true}) {
    if (isLoading) {
      Get.dialog(
        Dialog(
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: isblur ? 3.0 : 0,
              sigmaY: isblur ? 3.0 : 0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Center(
                      child: SizedBox(
                        width: 90,
                        height: 90,
                        child: Shimmer.fromColors(
                          baseColor: appColorDark,
                          highlightColor: Colors.blueAccent,
                          child: const CircularProgressIndicator(
                            strokeWidth: 1.5,
                          ),
                        ),
                      ),
                    ),
                    // Center(
                    //   child: Image.asset(
                    //     "assets/logo.png",
                    //     color: theme.isDark.value ? null : Colors.black26,
                    //     width: 80,
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(height: 15),
                Shimmer.fromColors(
                  baseColor: Colors.grey,
                  highlightColor: Colors.white,
                  period: const Duration(milliseconds: 3000),
                  child: Center(
                    child: help.text(
                      text: 'Please wait...',
                      color: Colors.grey,
                      size: 12,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        barrierDismissible: false,
      );

      // Return a function that can be used to hide the loading overlay
      return () {
        Get.back();
        return;
      };
    } else {
      return () {
        // Do nothing if not loading
      };
    }
  }

  //Custom image picker modal
  void customImagePickerModal({
    Widget? leading,
    Widget? title,
    bool isScrollControlled = false,
  }) {
    Get.bottomSheet(
      CupertinoActionSheet(
        title: Obx(
          () {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: leading,
                      ),
                      Container(child: title),
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor: Colors.grey.shade800,
                          child: help.icon(
                            icon: Icons.close,
                            size: 13,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  margin: EdgeInsets.zero,
                  color: !theme.isDark.value ? null : Colors.grey.shade900,
                  child: SizedBox(
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _customButon(
                              text: translator.translate("TAKE_PIC").value,
                              icon: CupertinoIcons.camera,
                              onTap: () => pickImage(ImageSource.camera)
                                  .whenComplete(() => Get.back()),
                            ),
                            _customButon(
                              text: translator.translate("CHOOSE_PIC").value,
                              icon: Icons.image_outlined,
                              onTap: () => pickImage(ImageSource.gallery)
                                  .whenComplete(() => Get.back()),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      barrierColor: Colors.transparent,
      isScrollControlled: isScrollControlled,
    );
  }

  Widget _customButon({
    required String text,
    required IconData icon,
    required void Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Obx(
        () {
          return ListTile(
            leading: help.text(
              text: text,
              size: 17,
            ),
            trailing: help.icon(
              icon: icon,
              size: 25,
              color: !theme.isDark.value ? Colors.grey.shade500 : Colors.white,
            ),
          );
        },
      ),
    );
  }

  //############################ Image picker ############################
  Future<XFile?> pickImage(ImageSource source) async {
    final picker = ImagePicker();

    try {
      image = await picker.pickImage(source: source);

      if (kIsWeb) {
        try {
          FilePickerResult? myImage = await FilePicker.platform.pickFiles(
            type: FileType.image,
          );

          if (myImage != null && myImage.files.isNotEmpty) {
            Uint8List? fileBytes = myImage.files.first.bytes;
            selectedImageForWeb.value = fileBytes;
            mycolors = await PaletteGenerator.fromImageProvider(
              FileImage(
                File(
                  selectedImage.value.toString(),
                ),
              ),
            );

            log("Generated Colors : ${mycolors.colors}");
            // update();
            Get.forceAppUpdate();
          } else {
            return null;
          }
        } catch (e) {
          // Handle the exception
          log(e.toString());
        }
      } else {
        if (image != null) {
          selectedImage.value = image;
        } else {
          return null;
        }
        Get.forceAppUpdate();
      }
    } on TimeoutException catch (e) {
      log(e.toString());
    }

    return null;
  }

//############################ Generate app color ############################

  Color myColor() {
    // Couleur de référence
    // const Color referenceColor = Color.fromARGB(255, 214, 208, 221);
    var c = mycolors.dominantColor?.color;
    Color referenceColor = c as Color;

    // Liste de couleurs excluant le gris, le blanc, et les couleurs similaires
    List<Color> excludedColors = mycolors.colors
        .where((color) =>
            !isSimilarToGray(color, tolerance: 30) &&
            !isSimilarToWhite(color, tolerance: 30) &&
            color != Colors.grey && // Exclure le gris
            color != Colors.white && // Exclure le blanc
            color != referenceColor)
        .toList();

    // Retourne la première couleur de la liste excluant le gris, le blanc, et les couleurs similaires
    return excludedColors.isNotEmpty ? excludedColors.first : color;
  }

  bool isSimilarToGray(Color color, {int tolerance = 0}) {
    return _isSimilarToColor(color, Colors.grey, tolerance);
  }

  bool isSimilarToWhite(Color color, {int tolerance = 0}) {
    return _isSimilarToColor(color, Colors.white, tolerance);
  }

  bool _isSimilarToColor(Color color, Color referenceColor, int tolerance) {
    return (color.red - referenceColor.red).abs() <= tolerance &&
        (color.green - referenceColor.green).abs() <= tolerance &&
        (color.blue - referenceColor.blue).abs() <= tolerance;
  }
  //############################ End of generating color ############################

  //########################## Custom bottom sheet ############################
  void customBottomSheet({
    required Widget body,
    required BuildContext context,
  }) {
    Get.bottomSheet(
      Scaffold(
        body: Wrap(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: help.icon(
                icon: Icons.horizontal_rule_outlined,
                color: Colors.grey.withOpacity(0.4),
                size: 40,
              ),
            ),
            body,
          ],
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      isScrollControlled: MediaQuery.of(context).viewInsets.bottom > 0,
    );
  }

//############################# Custom Dialog #################################
  void customDialog({
    required Widget body,
    Widget? title,
    Color? barrierColor,
    bool barrierDismissible = true,
  }) {
    Get.dialog(
      CupertinoAlertDialog(
        title: title ??
            help.icon(
              icon: Icons.info_outline,
              color: Colors.grey,
              size: 35,
            ),
        content: body,
      ),
      barrierColor: barrierColor,
      barrierDismissible: barrierDismissible,
    );
  }

  List<dynamic> onboardingListItem = [
    {
      // "image": "assets/images/save_your_money2.png",
      "image": "assets/images/save_your_money.png",
      "title": "Save your money",
      "subTitle": "Insurance of your deposits with a guarantee"
    },
    {
      "image": "assets/images/money_transfer.png",
      "title": "Money Transfer",
      "subTitle": "Fast money transfer with a minimum commission!"
    },
    {
      "image": "assets/images/cash_back.png",
      "title": "Cash Back",
      "subTitle": "Get 1% cash back on every purchase!"
    },
    {
      "image": "assets/images/donts_miss_the benefit.png",
      "title": "Don't miss the benefit!",
      "subTitle": "Earn on the exchange up to 15% per annum!"
    },
    {
      "image": "assets/images/pay_later.png",
      "title": "Buy Now Pay Later",
      "subTitle": "Easier and can pay later"
    },
  ];

  List<Color>? onboardingTitleColor;

  ///Generate and retrives List of Color from user profile image
  Future<List<Color>> getColors(Themes themes) async {
    List<Color> colorList = [];

    List<int> colorListInt = [];
    try {
      dynamic onboardingColor = await readDataFromStorage("localColor");

      //Get and convert local int color to color
      //Parse string data to list
      var parseData = jsonDecode(onboardingColor.toString());

      List<dynamic> lstring = parseData;
      List lint = lstring.map((e) => int.parse(e.toString())).toList();

      var storegeColor = lint.map((value) => Color(value)).toList();

      colorList = List.from(storegeColor);

      // log("Color from local storage");

      //Get country ISO code
      var countryIsoCode = await getIpAddressAndData("country");

      isoCode.value = countryIsoCode;

      return colorList;
    } catch (e) {
      for (var data in onboardingListItem) {
        var color0 = await PaletteGenerator.fromImageProvider(
          AssetImage(data['image']),
        );

        var dominantColor = color0.dominantColor?.color;

        if (dominantColor != null) {
          if (!themes.isDark.value &&
              (dominantColor == const Color(0xffe0e2e5) ||
                  dominantColor == Colors.grey)) {
            colorList.add(appColorDark);
            colorListInt.add(appColorDark.value);
          } else {
            colorList.add(dominantColor);
            colorListInt.add(dominantColor.value);
          }
        }

        // Store generated OnboardingColors in storage
        await writeDataToStorage("localColor", colorListInt);
        // log("Generated colors");
      }
      var countryIsoCode = await getIpAddressAndData("country");

      isoCode.value = countryIsoCode;
      return colorList;
    }
  }

  Future<String> getIpAddressAndData(String value) async {
    var headers = {
      'Access-Control-Allow-Origin': '*',
      "Access-Control-Allow-Methods": "GET, POST, OPTIONS",
      'Access-Control-Allow-Headers':
          'Origin, X-Requested-With, Content-Type, Accept'
    };
    try {
      final response = await http.get(
        // Uri.parse('https://ipinfo.io/$value'),
        Uri.parse("https://ipinfo.io/$value/?token=df7b0b1add402e"),
        headers: headers,
      );
      if (response.statusCode == 200) {
        return response.body.trim();
      } else {
        return 'Failed to get IP address';
      }
    } catch (e) {
      if (e.toString().contains('Failed host lookup')) {
        // errorHandler("NETWORK_CONNECTION_ERROR");
        log(e.toString());
      } else {
        log(e.toString());
      }
      return 'Failed to get IP address';
    }
  }

  @override
  void onInit() async {
    appColorDark = myColor();
    cardColor = [Colors.amber, appColorDark, Colors.blue, Colors.red];

    storage = const FlutterSecureStorage();
    super.onInit();
  }
}
