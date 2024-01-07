import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsomenenyo/helpers/index.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
          init: Themes(),
          builder: (_) {
            return FutureBuilder(
              future: help.getColors(_),
              builder: (context, snap) {
                var color = snap.data;
                // if (color == null || color.isEmpty) {
                //   return const Center(child: CircularProgressIndicator());
                // }
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                return const OnboradingScreen();
              },
            );
          }),
    );
  }

  // Future<Color> getColor(int index) async {
  //   var data = items[index];
  //   var color0 =
  //       await PaletteGenerator.fromImageProvider(AssetImage(data['image']));

  //   var colors = color0.dominantColor!.color;

  //   return colors;
  // }
}
