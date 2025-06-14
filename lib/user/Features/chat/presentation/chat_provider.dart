import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety/user/Features/chat/presentation/widgets/chat_provider_body.dart';
import 'package:taht_bety/user/Features/profile/data/models/provider_model/provider_model.dart';

class ChatProviderScreen extends StatelessWidget {
  const ChatProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProviderModel provider =
        GoRouterState.of(context).extra as ProviderModel;
    return ChatProviderScreenBody(provider: provider);
  }
}
