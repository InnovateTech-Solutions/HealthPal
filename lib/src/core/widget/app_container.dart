import 'package:flutter/material.dart';

class AppContainer extends StatelessWidget {
  const AppContainer({required this.imgName, required this.onTap, Key? key})
      : super(key: key);
  final String imgName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: const Offset(0, 2)),
            ],
            borderRadius: BorderRadius.circular(16.0),
            image: DecorationImage(
                image: NetworkImage(imgName), fit: BoxFit.cover),
          )),
    );
  }
}
