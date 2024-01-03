import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsomenenyo/helpers/index.dart';

import '../../controllers/index.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var padding = 25.0;
    var bgColor = Colors.grey.withOpacity(0.2);
    return Scaffold(
      backgroundColor: help.appColorDark,
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  top: padding - 10,
                  left: padding,
                  right: padding,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () {
                            currentIndex.value;
                            return GestureDetector(
                              onTap: () => backBtn(),
                              child: CircleAvatar(
                                backgroundColor: bgColor,
                                radius: 17.0,
                                child: help.icon(
                                  icon: CupertinoIcons.back,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            );
                          },
                        ),
                        help.text(
                            text: translator.translate("WALLET").value,
                            size: 19,
                            color: Colors.white),
                        help.icon(
                          icon: CupertinoIcons.bell_fill,
                          onTap: () => Get.toNamed("/notif"),
                          showBadge: true,
                          color: Colors.amber,
                          backgroundColor: bgColor,
                          badgeStyle: BadgeStyle(
                            borderSide: BorderSide(
                              color: bgColor,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),

                    //Income && Outcome
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Column(
                        children: [
                          //Total Amount
                          _buildBalance(amount: "564338.987"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _customCard(
                                icon: Icons.arrow_downward_rounded,
                                text: translator.translate("INCOME").value,
                                amount: "200000",
                              ),
                              _customCard(
                                icon: Icons.arrow_upward_outlined,
                                isOut: true,
                                text: translator.translate("OUTCOME").value,
                                amount: "14000",
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Obx(
              () {
                return Container(
                  // height: Get.height - Get.height * 0.3,
                  padding: EdgeInsets.only(
                    left: padding,
                    right: padding,
                    top: padding,
                  ),
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: theme.isDark.value
                        ? Get.theme.canvasColor
                        : Colors.white,
                    borderRadius: const BorderRadiusDirectional.only(
                        topStart: Radius.circular(35),
                        topEnd: Radius.circular(35)),
                  ),
                  child: Column(
                    children: [
                      //Chart bar button
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            10,
                            (index) => Card(
                              color: help.appColorDark.withOpacity(0.2),
                              child: Row(
                                children: [
                                  help.text(
                                      text:
                                          translator.translate("INCOME").value),
                                  help.icon(icon: Icons.arrow_drop_down_rounded)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // help.text(text: mycolors.colors.length.toString()),
                      // const SizedBox(height: 20),
                      Obx(() {
                        return help.text(
                            text: translator
                                .translate("OUTCOME")
                                .value
                                .toString());
                      }),
                      GestureDetector(
                        onTap: () async {
                          // translator = Get.put(Translator());
                          // initTranslation();

                          await translator.load(langCode: "fr");
                          Get.forceAppUpdate();
                        },
                        child: help.text(text: "Translate"),
                      )

                      // Expanded(
                      //   // scrollDirection: Axis.horizontal,
                      //   child: ListView(
                      //     children: List.generate(
                      //       mycolors.colors.length,
                      //       (index) {
                      //         mycolors.dominantColor?.color;
                      //         return CircleAvatar(
                      //           backgroundColor: mycolors.dominantColor?.color,
                      //         );
                      //       },
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

//Build total amount widget
  Widget _buildBalance({
    required String amount,
  }) {
    return Column(
      children: [
        help.text(
          text: translator.translate("BALANCE_TOTAL").value,
          color: Colors.white,
          size: 18,
          fontWeight: FontWeight.bold,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
          child: help.text(
            text: "$amount XOF",
            size: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  //Custom card
  Widget _customCard({
    required IconData icon,
    required String text,
    required String amount,
    bool isOut = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          color: help.appColorDark.withOpacity(.2),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Card(
                  color: help.appColorDark.withOpacity(0.1),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: help.icon(
                      icon: icon,
                      color: isOut ? Colors.redAccent : Colors.greenAccent,
                      size: 15,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      help.text(
                        text: text,
                        color: Colors.grey,
                        size: 13,
                      ),
                      help.text(
                        text: "$amount XOF",
                        color: Colors.white,
                        size: 13,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
