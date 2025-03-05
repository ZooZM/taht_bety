import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety/user/Features/product/data/basket_model.dart';
import 'package:taht_bety/user/Features/product/data/basket_storage.dart';
import 'package:taht_bety/user/Features/basket/presentation/view/widgets/basket_item_card.dart';
import 'package:taht_bety/user/Features/basket/presentation/view/widgets/total_bill.dart';

class Basket extends StatefulWidget {
  const Basket({super.key});

  @override
  _BasketState createState() => _BasketState();
}

class _BasketState extends State<Basket> {
  List<BasketModel> basketItems = [];

  @override
  void initState() {
    super.initState();
    loadBasket();
  }

  void loadBasket() {
    setState(() {
      basketItems = BasketStorage.getAllBasketItems();
    });
  }

  void removeItem(int index) async {
    String itemId = basketItems[index].id;
    await BasketStorage.removeFromBasket(itemId);

    setState(() {
      basketItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    basketItems = GoRouterState.of(context).extra as List<BasketModel>;

    int totalBill =
        basketItems.fold(0, (sum, item) => sum + (item.price * item.count));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Basket"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (GoRouter.of(context).canPop()) {
              GoRouter.of(context).pop();
            } else {
              context.go('/');
            }
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: basketItems.length,
              itemBuilder: (context, index) {
                final item = basketItems[index];

                return BasketItemCard(
                  item: item,
                  onRemove: () {
                    setState(() {
                      if (item.count > 1) {
                        item.count--;
                      }
                    });
                  },
                  onAdd: () {
                    setState(() {
                      item.count++;
                    });
                  },
                  onDelete: () {
                    removeItem(index);
                  },
                );
              },
            ),
          ),
          TotalBill(totalBill: totalBill),
        ],
      ),
    );
  }
}
