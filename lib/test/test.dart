import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  final String imageUrl;

  TestPage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Page'),
      ),
      body: Center(
        child: Image.network(imageUrl),
      ),
    );
  }
}
