import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/index.dart';
import '../../helpers/index.dart';
import '../index.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var padding = 25.0;
    var bgColor = Colors.grey.withOpacity(0.2);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.only(left: padding, right: padding, top: padding - 10),
          child: Column(
            children: [
              Obx(() {
                var colorValue = theme.isDark.value ? 0.1 : .3;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => backBtn(),
                      child: CircleAvatar(
                        radius: 17,
                        backgroundColor: Colors.grey.withOpacity(colorValue),
                        child: help.icon(
                          icon: CupertinoIcons.back,
                          color: theme.isDark.value
                              ? Colors.white
                              : Colors.black38,
                          size: 16,
                        ),
                      ),
                    ),
                    help.text(
                        text: translator.translate("SETTINGS").value, size: 19),
                    help.icon(
                      icon: CupertinoIcons.bell_fill,
                      color: Colors.amber,
                      badgeStyle: BadgeStyle(
                        borderSide: BorderSide(
                          color: bgColor,
                          width: 1.5,
                        ),
                      ),
                      showBadge: true,
                      backgroundColor: Colors.grey.withOpacity(colorValue),
                      onTap: () => Get.toNamed("/notif"),
                    )
                  ],
                );
              }),
              //Body contents
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(bottom: Get.height * 0.08, top: 10),
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      //User profile

                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 30.0),
                        child: GestureDetector(
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const CircleAvatar(radius: 30),
                            title: help.text(
                              text: "DavidSon",
                            ),
                            trailing: help.icon(
                              icon: CupertinoIcons.forward,
                              color: Colors.grey,
                              size: 16,
                            ),
                          ),
                          onTap: () => help.customBottomSheet(
                            context: context,
                            body: const EditeProfileScreen(),
                          ),
                        ),
                      ),
                      ...settingItems(context).map(
                        (e) {
                          List<dynamic> data0 = e["item"];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              e["label"] == null
                                  ? const SizedBox()
                                  : Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 18.0),
                                      child: help.text(
                                        text: e["label"],
                                        size: 17,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                              Column(
                                children: List.generate(data0.length, (index) {
                                  var data = data0[index];

                                  return GestureDetector(
                                    onTap: data["onTap"],
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Card(
                                            elevation: 0.4,
                                            margin: EdgeInsets.zero,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: ListTile(
                                                contentPadding: EdgeInsets.zero,
                                                enableFeedback: false,
                                                leading: help.icon(
                                                  icon: data["icon"],
                                                  color: data["color"],
                                                ),
                                                title: help.text(
                                                    text: data["title"]),
                                                trailing: Wrap(
                                                  crossAxisAlignment:
                                                      WrapCrossAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 10),
                                                      child:
                                                          data["subTrailing"] ??
                                                              const SizedBox(),
                                                    ),
                                                    data["trailing"] ??
                                                        help.icon(
                                                          icon: CupertinoIcons
                                                              .forward,
                                                          color: Colors.grey,
                                                          size: 16,
                                                        )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          data["subtitle"] == null
                                              ? const SizedBox()
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 6.0),
                                                  child: help.text(
                                                      text: data["subtitle"],
                                                      size: 13,
                                                      color: Colors.grey),
                                                ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ],
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
