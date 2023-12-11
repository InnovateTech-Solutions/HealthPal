import 'package:flutter/material.dart';
import 'package:healthpal/src/core/usecase/authentication/authentication.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () => Authentication().logout(),
              child: const Text('data'))
        ],
      ),
    );
  }
}
