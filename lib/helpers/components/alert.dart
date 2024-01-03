import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../index.dart';

void showAlertDialog({
  final String text = "",
  final String subTitle = "",
  String? assetName = 'error.json',
  final double? size,
  void Function()? validateAction,
  void Function()? onTapAction,
  final String? validateText,
  final String? action,
  final bool? repeat,
  final bool? reverse,
  final Widget? child,
  final FontWeight? bold,
  bool barrierDismissible = false,
  bool showConffeti = false,
  bool forTargetValidation = true,
  bool isOnlyValidator = false,
}) {
  if (isOnlyValidator) {
    Get.dialog(
      barrierDismissible: barrierDismissible,
      Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Lottie.asset(
                "assets/lotties/$assetName",
                repeat: false,
                fit: BoxFit.cover,
                width: 60,
              ),
            ),
          ),
        ),
      ),
    );
  } else {
    Get.dialog<void>(
      barrierDismissible: barrierDismissible,
      MyDialog(
        text: text,
        subTitle: subTitle,
        assetName: assetName,
        size: size,
        validateAction: validateAction,
        onTapAction: onTapAction,
        validateText: validateText,
        action: action,
        repeat: repeat,
        reverse: reverse,
        bold: bold,
        barrierDismissible: barrierDismissible,
        showConffeti: showConffeti,
        child: child,
      ),
    );
  }
}

class MyDialog extends StatelessWidget {
  final String text;
  final String subTitle;
  final String? assetName;
  final double? size;
  final void Function()? validateAction;
  final void Function()? onTapAction;
  final String? validateText;
  final String? action;
  final bool? repeat;
  final bool? reverse;
  final Widget? child;
  final FontWeight? bold;
  final bool barrierDismissible;
  final bool showConffeti;

  const MyDialog({
    super.key,
    this.text = "",
    this.subTitle = "",
    this.assetName = 'error.json',
    this.size,
    this.validateText,
    this.action,
    this.repeat,
    this.reverse,
    this.child,
    this.bold,
    this.barrierDismissible = false,
    this.showConffeti = false,
    this.validateAction,
    this.onTapAction,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 300),
      child: CupertinoAlertDialog(
        title: Lottie.asset(
          "assets/lotties/$assetName",
          height: size ?? 50,
          width: size ?? 50,
          repeat: repeat,
          reverse: reverse,
        ),
        content: ConfettiWidget(
          confettiController: conffetiController,
          blastDirectionality: BlastDirectionality
              .explosive, // don't specify a direction, blast randomly
          shouldLoop: true, // start again as soon as the animation is finished
          colors: const [
            Colors.green,
            Colors.blue,
            Colors.pink,
            Colors.orange,
            Colors.purple
          ], // manually specify the colors to be used
          createParticlePath: _drawStar, // define a custom shape/path.
          child: child ??
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  help.text(text: text, fontWeight: bold),
                  if (subTitle.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: help.text(
                          text: subTitle, color: Colors.grey, size: 12),
                    ),
                ],
              ),
        ),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDestructiveAction: action == null ? false : true,
            isDefaultAction: true,
            onPressed: validateAction ?? () => Get.back(),
            child: Text(action == null ? validateText ?? 'Okay' : 'Cancel'),
          ),
          if (action != null)
            CupertinoDialogAction(
              isDestructiveAction: false,
              isDefaultAction: true,
              onPressed: onTapAction ?? () => Get.back(),
              child: Text(action!),
            ),
        ],
      ),
    );
  }

  /// A custom Path to paint stars.
  Path _drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }
}
