import 'package:flutter/material.dart';
import 'package:taht_bety/user/Features/profile/presentation/widgets/serv_upper_widget.dart';

class ServiceProdfile extends StatelessWidget {
  const ServiceProdfile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          ServUpperWidget(),
        ],
      ),
    );
  }
}
