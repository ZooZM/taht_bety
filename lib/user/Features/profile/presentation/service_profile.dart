import 'package:flutter/material.dart';
import 'package:taht_bety/user/Features/profile/presentation/widgets/service_profile_body.dart';

class ServiceProfile extends StatelessWidget {
  const ServiceProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: ServiceProfileBody(),
      ),
    );
  }
}
