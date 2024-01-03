import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsomenenyo/controllers/index.dart';
import 'package:tsomenenyo/validators/user_validator.dart';

import '../../helpers/index.dart';

class BugRaportScreen extends StatelessWidget {
  const BugRaportScreen({Key? key}) : super(key: key);

  static final TextEditingController _phoneController =
      TextEditingController(text: "91680967");
  @override
  Widget build(BuildContext context) {
    phoneController = _phoneController;
    return Obx(
      () {
        return Padding(
          padding: const EdgeInsets.only(top: 2.0, left: 20, right: 20),
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: help.text(
                    text: translator.translate("SEND_RAPORT").value,
                    size: 17,
                    color: Colors.grey,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Column(
                  children: [
                    CustomForm(
                      controller: phoneController,
                      textInputType: TextInputType.phone,
                      readOnly: true,
                    ),
                    const SizedBox(height: 20),
                    CustomForm(
                      controller: messageController,
                      textInputType: TextInputType.text,
                      maxLines: 4,
                      label: translator.translate("MESSAGE_TYPING").value,
                    ),
                    help.onSendButn(
                      title: translator.translate("SEND_RAPORT_BTN").value,
                      isValidate: messageController.text.isNotEmpty,
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
