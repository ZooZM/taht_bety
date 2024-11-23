import 'package:flutter/material.dart';
import 'package:taht_bety/constants.dart';

class CustomCircularprogress extends StatelessWidget {
  const CustomCircularprogress({super.key, required this.size});
  final double size;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: const CircularProgressIndicator(
        color: ksecondryColor,
      ),
    );
  }
}
