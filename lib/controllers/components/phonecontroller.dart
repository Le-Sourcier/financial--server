import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../helpers/index.dart';
import '../index.dart';

class InputPhoneNumber extends StatelessWidget {
  final TextEditingController controller;
  final String initialCountry;
  final bool showFlags;
  final PhoneInputSelectorType selectorType;
  final bool trailingSpace;
  final TextInputAction? textInputAction;
  final bool readOnly;
  final double? hintSize;
  final Color? inputColor;

  const InputPhoneNumber({
    Key? key,
    required this.controller,
    this.initialCountry = 'US',
    this.showFlags = false,
    this.trailingSpace = false,
    this.selectorType = PhoneInputSelectorType.BOTTOM_SHEET,
    this.textInputAction,
    this.readOnly = false,
    this.hintSize,
    this.inputColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PhoneController>(
      init: PhoneController(
        controller: controller,
        initialCountry: initialCountry,
      ),
      builder: (phone) {
        var code = "".obs;
        return Obx(
          () {
            Color color = theme.isDark.value ? Colors.grey : Colors.black;
            return Card(
              color: inputColor,
              child: InternationalPhoneNumberInput(
                spaceBetweenSelectorAndTextField: 0,
                isEnabled: !readOnly,
                locale: initialCountry,
                keyboardAction: textInputAction,
                maxLength: phone.maxLength.value,
                onInputChanged: (PhoneNumber number) {
                  code.value = '${number.isoCode}';

                  help.dialCode.value =
                      number.dialCode.toString().replaceFirst("+", "");
                  if (help.dialCode.value.isEmpty) {
                    help.dialCode.value =
                        number.dialCode.toString().replaceFirst("+", "");
                  } else {
                    help.dialCode.value =
                        number.dialCode.toString().replaceFirst("+", "");
                  }
                },
                searchBoxDecoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(5),
                  constraints: BoxConstraints(maxWidth: Get.width / 1.112),
                  focusColor: Colors.transparent,
                  filled: true,
                  fillColor: theme.isDark.value
                      ? Colors.grey.shade800.withOpacity(0.2)
                      : Colors.grey.shade700.withOpacity(0.2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    gapPadding: .4,
                    borderSide: BorderSide.none,
                  ),
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                  prefixIcon: help.icon(
                    icon: CupertinoIcons.search,
                    size: 18,
                  ),
                  hintText: 'Search Country',
                  // hintText:
                  // 'Ex: ${code.value.isEmpty ? phone.number.isoCode : code.value} or +${help.dialCode.value}',
                  // label: help.text(
                  //   text: 'Search Country',
                  //   color: Colors.grey,
                  //   size: 13,
                  // ),
                ),
                onInputValidated: phone.onInputValidated,
                selectorConfig: SelectorConfig(
                  trailingSpace: trailingSpace,
                  useBottomSheetSafeArea: true,
                  showFlags: showFlags,
                  leadingPadding: 15,
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                ),
                ignoreBlank: false,
                autoValidateMode: AutovalidateMode.disabled,
                selectorTextStyle: TextStyle(color: color),
                initialValue: phone.number,
                textFieldController: controller,
                formatInput: true,
                keyboardType: const TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                onSaved: (PhoneNumber number) {},
                inputDecoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(20),
                  hintMaxLines: phone.maxLength.toInt(),
                  border:
                      const UnderlineInputBorder(borderSide: BorderSide.none),
                  hintText: translator.translate("PHONE").value,
                  hintStyle:
                      TextStyle(color: Colors.grey, fontSize: hintSize ?? 13),
                  suffixIcon: isNumValidate.value
                      ? Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SizedBox(
                            width: 3,
                            height: 3,
                            child: Lottie.asset(
                              'assets/lotties/validate.json',
                              repeat: false,
                            ),
                          ),
                        )
                      : const SizedBox(),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class PhoneController extends GetxController {
  final TextEditingController controller;
  final String initialCountry;

  PhoneController({
    required this.controller,
    this.initialCountry = 'US',
  });

  late PhoneNumber number;
  late void Function(bool) onInputValidated;
  late RxInt maxLength;
  late RxString dialCode;

  @override
  void onInit() {
    number = PhoneNumber(isoCode: initialCountry);
    maxLength = 15.obs;
    dialCode = RxString(number.dialCode.toString());
    onInputValidated = (bool value) {
      if (value) {
        maxLength = controller.text.length.obs;
        isNumValidate.value = true;
        update();
      } else {
        isNumValidate.value = false;
        update();
      }

      dialCode = RxString(number.dialCode.toString());
    };

    super.onInit();
  }

  @override
  void onClose() {
    // controller.dispose();
    super.onClose();
  }
}
