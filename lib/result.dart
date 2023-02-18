import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int result;

  const Result({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: Center(
        child: Text('The outlier is: $result'),
      ),
    );
  }
}