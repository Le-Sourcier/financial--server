import 'package:flutter/material.dart';

import '../../index.dart';

class BigScreen extends StatelessWidget {
  const BigScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: 60,
        ),
        IndexedStack(
          children: [
            Container(
              child: help.text(text: "DDDD"),
            ),
            Container(
              child: help.text(text: "XXXX"),
            ),
          ],
        )
      ],
    );
  }
}
