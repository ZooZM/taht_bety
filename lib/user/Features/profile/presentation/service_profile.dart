import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety/user/Features/profile/data/models/provider_model/provider_model.dart';
import 'package:taht_bety/user/Features/profile/presentation/widgets/service_profile_body.dart';

class ServiceProfile extends StatelessWidget {
  const ServiceProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = GoRouterState.of(context).extra as ProviderModel?;
    return Scaffold(
      body: SafeArea(
        child: ServiceProfileBody(
          provider: provider!,
        ),
      ),
    );
  }
}
