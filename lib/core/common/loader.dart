import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Loader extends StatelessWidget {
  Color color;
  Loader({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color,
      ),
    );
  }
}
