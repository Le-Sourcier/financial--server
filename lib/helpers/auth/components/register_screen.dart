import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsomenenyo/controllers/index.dart';
import 'package:tsomenenyo/helpers/index.dart';
import 'package:tsomenenyo/validators/user_validator.dart';

class RegisterScreen extends StatelessWidget {
  final PageController? controller;
  const RegisterScreen({Key? key, this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var radius = const Radius.circular(35);
    var inputColor = (theme.isDark.value
            ? Colors.grey.shade800.withOpacity(0.2)
            : Colors.grey.shade100.withOpacity(0.9))
        .obs;
    var duration = const Duration(milliseconds: 400);
    return GetBuilder(
        init: RegisterDataInit(),
        builder: (_) {
          return Obx(
            () {
              return Hero(
                tag: 'cForm',
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
                    padding:
                        const EdgeInsets.only(top: 25, left: 20, right: 20),
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
                                text:
                                    translator.translate("SIGN_UP_TITLE").value,
                                size: 26,
                                fontWeight: FontWeight.bold,
                                color: theme.isDark.value
                                    ? Colors.white70
                                    : Colors.grey.shade900.withOpacity(0.7),
                              ),
                              help.text(
                                text: translator.translate("SIGN_UP_SUB").value,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                size: 13,
                              ),
                            ],
                          ),
                        ),
                        CustomForm(
                          textInputType: TextInputType.name,
                          controller: nameController,
                          inputColor: inputColor.value,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 15.0, bottom: 0.0),
                          child: CustomForm(
                            textInputType: TextInputType.emailAddress,
                            controller: emailController,
                            inputColor: inputColor.value,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 15.0, bottom: 0.0),
                          child: CustomForm(
                            textInputType: TextInputType.phone,
                            controller: phoneController,
                            inputColor: inputColor.value,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 15.0, bottom: 0.0),
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
                              Expanded(
                                child: GestureDetector(
                                  child: help.text(
                                    text: translator
                                        .translate("SIGN_UP_REF")
                                        .value,
                                    color: Colors.blue,
                                    overflow: TextOverflow.ellipsis,
                                    size: 13,
                                  ),
                                  onTap: () {
                                    controller?.jumpToPage(0);
                                  },
                                ),
                              ),
                              Expanded(
                                child: help.onSendButn(
                                  title: translator.translate("SIGN_UP").value,
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
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }
}

class RegisterDataInit extends GetxController {
  // Future<PaletteGenerator> _init() async {
  //   if (help.image != null) {
  //     return await PaletteGenerator.fromImageProvider(
  //       // const AssetImage("assets/1.png"));
  //       // const AssetImage("assets/image2.png"),
  //       FileImage(
  //         help.image,
  //       ),
  //     );
  //   } else {
  //     return;
  //   }
  // }

  @override
  void onInit() async {
    // mycolors = await _init();

    // log("Selected image colors : ${mycolors.colors}");
    super.onInit();
  }
}
