import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsomenenyo/controllers/index.dart';
import 'package:tsomenenyo/helpers/index.dart';
import 'package:tsomenenyo/validators/user_validator.dart';

class LoginScreen extends StatelessWidget {
  final PageController? controller;
  const LoginScreen({Key? key, this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var radius = const Radius.circular(35);
    var inputColor = (theme.isDark.value
            ? Colors.grey.shade800.withOpacity(0.2)
            : Colors.grey.shade100.withOpacity(0.9))
        .obs;
    var duration = const Duration(milliseconds: 500);
    return Obx(
      () {
        return Hero(
          tag: "cForm",
          child: Card(
            elevation: 0.5,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: radius,
                topRight: radius,
              ),
            ),
            child: AnimatedContainer(
              duration: duration,
              padding: const EdgeInsets.only(top: 25, left: 20, right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: radius,
                  topRight: radius,
                ),
              ),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25.0),
                    child: Column(
                      children: [
                        help.text(
                          text: translator.translate("SIGN_IN_TITLE").value,
                          size: 26.0,
                          fontWeight: FontWeight.bold,
                          color: theme.isDark.value
                              ? Colors.white70
                              : Colors.grey.shade900.withOpacity(0.7),
                        ),
                        help.text(
                          text: translator.translate("SIGN_IN_SUB").value,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          size: 13,
                        ),
                      ],
                    ),
                  ),
                  CustomForm(
                    textInputType: TextInputType.emailAddress,
                    controller: emailController,
                    inputColor: inputColor.value,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 0.0),
                    child: CustomForm(
                      textInputType: TextInputType.visiblePassword,
                      controller: passwordController,
                      inputColor: inputColor.value,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: GestureDetector(
                            child: help.text(
                              text: translator.translate("SIGN_IN_REF").value,
                              color: Colors.blue,
                              overflow: TextOverflow.ellipsis,
                              size: 13,
                            ),
                            onTap: () {
                              controller?.jumpToPage(1);
                            },
                          ),
                        ),
                        Flexible(
                          // flex: 2,
                          child: help.onSendButn(
                            title: translator.translate("SIGN_IN").value,
                            titleSize: 13,
                            backgroundColor: help.color,
                            fontWeight: FontWeight.bold,
                            isValidate: true,
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Divider(
                          thickness: 2,
                          height: 2,
                          color: Colors.red,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: help.text(text: "OR"),
                        ),
                        const Divider(
                          thickness: 2,
                          height: 2,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_socialIcon.length, (index) {
                        var icon = _socialIcon[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 0.7,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: CircleAvatar(
                              backgroundColor: icon["bgColor"] ?? Colors.white,
                              child: Image.asset(
                                icon["icon"],
                                width: icon["size"],
                                fit: BoxFit.cover,
                                color: icon['color'],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static final List<dynamic> _socialIcon = [
    {
      "icon": "assets/social_icon/google.png",
      "size": 35.0,
    },
    {
      "icon": "assets/social_icon/facebook.png",
    },
    {
      "icon": "assets/social_icon/x.png",
      "size": 23.0,
    },
    {
      "icon": "assets/social_icon/github.png",
      "bgColor": Colors.black,
    },
  ];
}
