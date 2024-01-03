import 'package:flutter/material.dart';

class SideBard extends StatelessWidget {
  const SideBard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(),
          const Center(
            child: Text('SideBard'),
          ),
        ],
      ),
    );
  }
}
