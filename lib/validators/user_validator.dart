import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

import '../controllers/index.dart';
import '../helpers/index.dart';

class CustomForm extends StatelessWidget {
  final TextInputType textInputType;
  final IconData? icon;
  final String? label;
  final double? elevation;
  final int maxLines;
  final bool readOnly;
  final double? hintSize;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final Color? inputColor;
  const CustomForm({
    super.key,
    required this.textInputType,
    this.label,
    this.icon,
    this.elevation,
    this.maxLines = 1,
    this.readOnly = false,
    required this.controller,
    this.hintSize,
    this.onChanged,
    this.inputColor,
  });

  @override
  Widget build(BuildContext context) {
    var isVisible = false.obs;
    switch (textInputType) {
      case TextInputType.phone:
      case TextInputType.number:
        return Obx(
          () {
            return InputPhoneNumber(
              controller: controller,
              showFlags: true,
              initialCountry: help.isoCode.value,
              readOnly: readOnly,
              hintSize: hintSize,
              inputColor: inputColor,
            );
          },
        );
      case TextInputType.emailAddress:
        return Obx(
          () {
            return _input(
              controller: controller,
              keyboardType: TextInputType.emailAddress,
              validator: ValidationBuilder()
                  .email()
                  .required("Email field are required")
                  .build(),
              icon: CupertinoIcons.at,
              lable: label ?? translator.translate("EMAIL").value,
              elevation: elevation,
              maxLines: maxLines,
              readOnly: readOnly,
              hintSize: hintSize,
              onChanged: onChanged,
              inputColor: inputColor,
            );
          },
        );
      case TextInputType.name:
        return Obx(
          () {
            return _input(
              controller: controller,
              keyboardType: TextInputType.name,
              validator: ValidationBuilder()
                  .required("Name field are required")
                  .build(),
              lable: label ?? translator.translate("NAME").value,
              icon: icon ?? CupertinoIcons.person,
              elevation: elevation,
              maxLines: maxLines,
              readOnly: readOnly,
              hintSize: hintSize,
              onChanged: onChanged,
              inputColor: inputColor,
            );
          },
        );
      case TextInputType.datetime:
        return _input(
          controller: controller,
          keyboardType: TextInputType.datetime,
          validator: ValidationBuilder().required().build(),
          lable: label ?? "",
          icon: icon,
          elevation: elevation,
          maxLines: maxLines,
          readOnly: readOnly,
          hintSize: hintSize,
          onChanged: onChanged,
          inputColor: inputColor,
        );
      case TextInputType.visiblePassword:
        return Obx(
          () {
            isVisible.value;
            return _input(
              controller: controller,
              keyboardType: TextInputType.visiblePassword,
              validator: ValidationBuilder()
                  .regExp(RegExp(""), "Password invalid!")
                  .required("Password field are required")
                  .build(),
              icon: icon ?? Icons.password,
              obscureText: !isVisible.value,
              lable: label ?? translator.translate("PASSWORD").value,
              suffixIcon: GestureDetector(
                child: _icon(
                  icon: isVisible.value
                      ? CupertinoIcons.eye
                      : CupertinoIcons.eye_slash,
                ),
                onTap: () {
                  isVisible.value = !isVisible.value;
                },
              ),
              elevation: elevation,
              maxLines: maxLines,
              readOnly: readOnly,
              hintSize: hintSize,
              onChanged: onChanged,
              inputColor: inputColor,
            );
          },
        );
      default:
        return _input(
          controller: controller,
          keyboardType: TextInputType.text,
          validator: ValidationBuilder().required("Field are required").build(),
          lable: label ?? "",
          icon: icon,
          elevation: elevation,
          maxLines: maxLines,
          readOnly: readOnly,
          hintSize: hintSize,
          onChanged: onChanged,
          inputColor: inputColor,
        );
    }
  }

  Widget _input({
    required TextInputType keyboardType,
    String? Function(String?)? validator,
    required String lable,
    IconData? icon,
    double size = 22.0,
    bool obscureText = false,
    Widget? suffixIcon,
    double? elevation,
    int? maxLines = 1,
    bool readOnly = false,
    double? hintSize,
    TextEditingController? controller,
    void Function(String)? onChanged,
    Color? inputColor,
  }) {
    return Card(
      elevation: elevation,
      color: inputColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: TextFormField(
          onChanged: onChanged,
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          obscureText: obscureText,
          obscuringCharacter: '*',
          maxLines: maxLines,
          readOnly: readOnly,
          decoration: InputDecoration(
            icon: icon == null
                ? null
                : _icon(
                    icon: icon,
                    size: size,
                  ),
            suffixIcon: suffixIcon,
            hintText: lable,
            hintStyle: TextStyle(color: Colors.grey, fontSize: hintSize ?? 14),
            contentPadding: const EdgeInsets.all(20),
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget _icon({
    required IconData icon,
    double size = 20,
  }) {
    return Icon(
      icon,
      size: size,
      color: Colors.grey,
    );
  }
}
