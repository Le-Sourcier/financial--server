import 'dart:io';

import 'package:badges/badges.dart' as badge;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tsomenenyo/controllers/index.dart';
import 'package:tsomenenyo/validators/user_validator.dart';

import '../../helpers/index.dart';

class EditeProfileScreen extends StatelessWidget {
  const EditeProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    XFile? profileImage = help.selectedImage.value;
    var isValid = false.obs;
    return Padding(
      padding: const EdgeInsets.only(top: 2.0, left: 20, right: 20),
      child: Wrap(
        children: [
          // Align(
          //   alignment: Alignment.topCenter,
          //   child: help.icon(
          //     icon: Icons.horizontal_rule_outlined,
          //     color: Colors.grey.withOpacity(0.4),
          //     size: 40,
          //   ),
          // ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25.0),
                    child: GestureDetector(
                      child: badge.Badge(
                        position:
                            badge.BadgePosition.bottomEnd(end: 4, bottom: 2),
                        badgeContent: help.icon(
                          icon: CupertinoIcons.camera_fill,
                          color: Colors.grey,
                        ),
                        badgeStyle: badge.BadgeStyle(
                          badgeColor: Get.theme.canvasColor,
                          padding: const EdgeInsets.all(8.0),
                          borderSide: BorderSide.none
                          // color: Get.theme.canvasColor,
                          // width: 4,
                          ,
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: profileImage != null
                              ? FileImage(File(profileImage.path))
                              : null,
                        ),
                      ),
                      onTap: () => help.customImagePickerModal(
                        leading: CircleAvatar(
                          backgroundImage: profileImage != null
                              ? FileImage(File(profileImage.path))
                              : null,
                        ),
                        title: help.text(
                          text: translator.translate("EDITE_PROFILE").value,
                          size: 15,
                        ),
                        isScrollControlled:
                            MediaQuery.of(context).viewInsets.bottom > 0,
                      ),
                    ),
                  ),
                  Obx(
                    () {
                      return Column(
                        children: [
                          CustomForm(
                            controller: nameController,
                            textInputType: TextInputType.name,
                            onChanged: (val) {
                              nameController.text = val;
                              if (val.trim().isNotEmpty) {
                                isValid.value = true;
                              } else {
                                isValid.value = false;
                              }
                            },
                          ),
                          const SizedBox(height: 20),
                          CustomForm(
                              readOnly: true,
                              controller: phoneController,
                              textInputType: TextInputType.phone),
                          help.onSendButn(
                            title: translator.translate("UPDATE").value,
                            isValidate: isValid.value,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
