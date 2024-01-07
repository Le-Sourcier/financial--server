import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:badges/badges.dart' as badge;

import '../../index.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({Key? key}) : super(key: key);
  static var pageController = PageController();
  @override
  Widget build(BuildContext context) {
    var currentIndex = 0.obs;
    var duration = const Duration(milliseconds: 500);
    // var isSignUp = false.obs;
    XFile? profileImage = help.selectedImage.value;
    return Scaffold(
      backgroundColor: theme.isDark.value ? null : Colors.grey.shade900,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/signin.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Obx(
          () {
            return Column(
              children: [
                Expanded(
                  flex: 1,
                  child: AnimatedContainer(
                    duration: duration,
                    decoration: const BoxDecoration(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: currentIndex.value == 0
                              ? null
                              : () async => help.customImagePickerModal(),
                          child: badge.Badge(
                            showBadge: currentIndex.value != 0,
                            badgeAnimation: const badge.BadgeAnimation.scale(),
                            position: badge.BadgePosition.bottomEnd(
                                end: 5, bottom: 6),
                            badgeContent: help.icon(
                              icon: CupertinoIcons.camera_fill,
                              color: Colors.grey,
                              size: 22,
                            ),
                            badgeStyle: badge.BadgeStyle(
                              badgeColor: theme.isDark.value
                                  ? Get.theme.cardColor
                                  : Colors.grey.shade900,
                              padding: const EdgeInsets.all(8.0),
                              borderSide: BorderSide.none,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: CircleAvatar(
                                radius: 50.0,
                                backgroundColor: theme.isDark.value
                                    ? Get.theme.cardColor
                                    : Colors.grey.shade800.withOpacity(0.3),
                                backgroundImage: currentIndex.value != 0 &&
                                        profileImage != null
                                    ? FileImage(File(profileImage.path))
                                    : null,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: currentIndex.value != 0 &&
                                          profileImage != null
                                      ? null
                                      : Lottie.asset(
                                          "assets/lotties/person.json",
                                          fit: BoxFit.cover,
                                          height: Get.height,
                                          width: Get.width,
                                          repeat: false,
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: currentIndex.value == 0 ? 2 : 3,
                  child: PageView(
                    controller: pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: page,
                    onPageChanged: (index) {
                      currentIndex.value = index;
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  static var page = [
    LoginScreen(controller: pageController),
    RegisterScreen(controller: pageController)
  ];
}
