import 'package:flutter/material.dart';
import 'package:taht_bety/user/Features/Home/home_page.dart';
import 'package:taht_bety/user/Features/Home/widgets/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SafeArea(
        child: Profile(),
      ),
    );
  }
}
