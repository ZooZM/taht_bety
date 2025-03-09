import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety/core/utils/app_router.dart';
import 'package:taht_bety/user/Features/basket/presentation/view/widgets/basket_body.dart';

class Basket extends StatefulWidget {
  const Basket({super.key});

  @override
  _BasketState createState() => _BasketState();
}

class _BasketState extends State<Basket> {
  // String? providerId;
  void didChangeDependencies() async {
    super.didChangeDependencies();
    // providerId = await GoRouterState.of(context).extra as String?;
  }

  @override
  Widget build(BuildContext context) {
    final providerId = GoRouterState.of(context).extra as String?;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Basket"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (GoRouter.of(context).canPop()) {
              GoRouter.of(context).pop();
            } else {
              context.go(AppRouter.kHomePage);
            }
          },
        ),
      ),
      body: BasketBody(providerID: providerId!),
    );
  }
}
