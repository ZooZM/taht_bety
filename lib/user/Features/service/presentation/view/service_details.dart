import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety/user/Features/profile/data/models/provider_model/post.dart';
import 'package:taht_bety/user/Features/service/presentation/view/widgets/service_details_body.dart';

class ServiceDetails extends StatelessWidget {
  const ServiceDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final post = GoRouterState.of(context).extra as Post;
    return Scaffold(
      body: SafeArea(
        child: ServiceDetailsBody(post: post),
      ),
    );
  }
}
