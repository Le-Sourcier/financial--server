import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../helpers/layout/index.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static double padding = 10.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        final isMobile = constraints.maxWidth <= 480 &&
            (defaultTargetPlatform == TargetPlatform.iOS ||
                defaultTargetPlatform == TargetPlatform.android);

        final isTablete = constraints.maxWidth <= 780 &&
            (defaultTargetPlatform == TargetPlatform.iOS ||
                defaultTargetPlatform == TargetPlatform.android);
        if (!isMobile) {
          return const SmallScreen();
        } else if (!isTablete) {
          return const Center(
            child: Text('HomeScreen'),
          );
        }
        return const Center(
          child: Text('HomeScreen'),
        );
      }),
    );
  }
}
