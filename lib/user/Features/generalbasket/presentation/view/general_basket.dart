import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety/core/utils/app_router.dart';
import 'package:taht_bety/user/Features/generalbasket/presentation/view/widgets/general_basket_body.dart';
import 'package:taht_bety/user/Features/product/data/basket_model.dart';

class GeneralBasket extends StatelessWidget {
  const GeneralBasket({super.key});

  @override
  Widget build(BuildContext context) {
    final baskets = GoRouterState.of(context).extra as List<BasketModel>?;
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
      body: GeneralBasketBody(basketItems: baskets!),
    );
  }
}
