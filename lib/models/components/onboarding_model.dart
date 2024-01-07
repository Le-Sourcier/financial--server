import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsomenenyo/screens/components/home_screen.dart';

import '../../helpers/index.dart';

class OnbordingModel extends StatelessWidget {
  final List<dynamic> items;
  final void Function() onTap;

  const OnbordingModel({
    Key? key,
    required this.items,
    required this.onTap,
  }) : super(key: key);

  static final PageController controller = PageController();
  static final RxInt currentIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          return Stack(
            children: [
              PageView.builder(
                controller: controller,
                itemCount: items.length,
                itemBuilder: (_, i) {
                  var data = items[i];
                  var color = help.onboardingTitleColor?[i];
                  return Stack(
                    children: [
                      Image.asset(
                        data["image"],
                        fit: BoxFit.cover,
                        height: Get.height,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            right: 20.0,
                            bottom: 90.0,
                          ),
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.center,
                            children: [
                              Column(
                                children: [
                                  // if (currentIndex.value == i + 1)
                                  //   Card(
                                  //     color: Colors.red,
                                  //     child: SizedBox(
                                  //       height: 15.0,
                                  //       child: help.text(text: "dd"),
                                  //     ),
                                  //   ),
                                  // if (currentIndex.value == i + 1)
                                  if (currentIndex.value == items.length - 1)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 25.0),
                                      child: Card(
                                        color: color,
                                        child: InkWell(
                                          enableFeedback: false,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          onTap: onTap,
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: help.text(
                                              text: "GET'S START",
                                              size: 15.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          // onTap: () {
                                          //   Get.offAll(
                                          //     () => const HomeScreen(),
                                          //     routeName: "/home",
                                          //     transition: Transition.topLevel,
                                          //     curve:
                                          //         Curves.fastLinearToSlowEaseIn,
                                          //   );
                                          // },
                                        ),
                                      ),
                                    ),
                                  help.text(
                                    text: data["title"],
                                    size: 35.0,
                                    fontWeight: FontWeight.bold,
                                    color: color,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6.0),
                                    child: FadeInUp(
                                      // key: UniqueKey(),
                                      child: help.text(
                                        text: data["subTitle"],
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              // ListTile(
                              //   title: FadeInLeft(
                              //     // key: UniqueKey(),
                              //     child: help.text(
                              //       text: data["title"],
                              //       size: 25.0,
                              //       fontWeight: FontWeight.bold,
                              //       color: color,
                              //     ),
                              //   ),
                              //   subtitle: FadeInUp(
                              //     // key: UniqueKey(),
                              //     child: help.text(
                              //       text: data["subTitle"],
                              //       color: Colors.grey,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
                onPageChanged: (index) {
                  currentIndex.value = index; // Use assignment operator
                  controller.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    bottom: 20.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: List.generate(
                          items.length,
                          (index) {
                            var color = help.onboardingTitleColor?[index];
                            return GestureDetector(
                              onTap: () {
                                // Use animateToPage for smooth animation
                                controller.animateToPage(
                                  index,
                                  duration: const Duration(milliseconds: 800),
                                  curve: Curves.linear,
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 6),
                                decoration: BoxDecoration(
                                  color: currentIndex.value == index
                                      ? color ?? Colors.grey
                                      : help.appColorDark,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: SizedBox(
                                  width:
                                      currentIndex.value == index ? 25.0 : 6.0,
                                  height:
                                      currentIndex.value == index ? 6.0 : 6.0,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      if (currentIndex.value != items.length - 1)
                        FadeInUp(
                          animate: true,
                          child: GestureDetector(
                            child: help.text(
                              text: "Sign Up",
                              color: help.onboardingTitleColor?[
                                      currentIndex.value] ??
                                  help.appColorDark,
                              fontWeight: FontWeight.bold,
                            ),
                            onTap: () {},
                          ),
                        )
                      else
                        FadeOutDown(
                          animate: true,
                          child: GestureDetector(
                            child: help.text(
                              text: "Sign Up",
                              color: help.appColorDark,
                              fontWeight: FontWeight.bold,
                            ),
                            onTap: () {},
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              if (currentIndex.value != items.length - 1)
                FadeInRight(
                  child: _skipBtn(onTap),
                )
              else
                FadeOutRight(
                  animate: true,
                  child: _skipBtn(onTap),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _skipBtn(void Function() onTap) {
    return GestureDetector(
      onTap: () {
        controller.animateToPage(
          4,
          duration: const Duration(milliseconds: 800),
          curve: Curves.linear,
        );
      },
      child: SafeArea(
        child: Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0, right: 25.0),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                help.text(text: "Skip"),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: theme.isDark.value
                        ? Colors.grey.shade800.withOpacity(0.3)
                        : Colors.grey.withOpacity(0.5),
                    child: help.icon(
                      icon: CupertinoIcons.forward,
                      color: Colors.white,
                      size: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
