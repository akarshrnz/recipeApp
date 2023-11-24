import 'package:flutter/material.dart';

class SizedboxWidget extends StatelessWidget {
  final double? height;
  final double? width;
  const SizedboxWidget({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height,width: width,);
  }
}