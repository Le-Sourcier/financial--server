import 'package:flutter/material.dart';

class Error404Screen extends StatelessWidget {
  const Error404Screen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error404Screen'),
      ),
      body: const Center(
        child: Text('Error404Screen'),
      ),
    );
  }
}
