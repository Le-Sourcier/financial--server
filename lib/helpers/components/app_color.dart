import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/index.dart';
import '../index.dart';

class AppColor extends StatelessWidget {
  const AppColor({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Obx(
        () {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: help.text(
                        text: translator.translate("CARD_COLOR_TITLE").value,
                        color: Colors.grey,
                        size: 17,
                      ),
                    ),
                    GestureDetector(
                      child: help.icon(
                        icon: Icons.info_outline,
                        color: Colors.grey,
                        size: 20,
                      ),
                      onTap: () => help.customDialog(
                        barrierColor: Colors.transparent,
                        body: help.text(
                            text:
                                translator.translate("CARD_COLOR_INFO").value),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Wrap(
                  // scrollDirection: Axis.horizontal,
                  children: [
                    ...List.generate(
                      mycolors.colors.length,
                      (index) {
                        List<Color> color =
                            mycolors.colors.map((e) => e).toList();
                        return GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: color[index],
                            ),
                          ),
                          onTap: () {
                            log(color[index].toString());
                          },
                        );
                      },
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
