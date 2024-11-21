import 'package:flutter/material.dart';
import 'package:taht_bety/core/utils/api_service.dart';
import 'package:taht_bety/user/Features/Home/data/repos/home_repo.dart';
import 'package:taht_bety/user/Features/Home/data/repos/home_repo_implementain.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/home_page.dart';
import 'package:taht_bety/user/Features/profile/presentation/service_profile.dart';
import 'package:taht_bety/user/Features/profile/presentation/user_profile.dart';
import 'package:taht_bety/user/Features/search/presentation/search.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      showSemanticsDebugger: false,
      home: SafeArea(
        child: HomePage(),
      ),
    );
  }
}
