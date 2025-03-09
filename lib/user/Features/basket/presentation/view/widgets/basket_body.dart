import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:taht_bety/data.dart';
import 'package:taht_bety/user/Features/basket/presentation/view/widgets/basket_item_card.dart';
import 'package:taht_bety/user/Features/basket/presentation/view/widgets/total_bill.dart';
import 'package:taht_bety/user/Features/product/data/basket_model.dart';
import 'package:taht_bety/user/Features/product/data/basket_storage.dart';

class BasketBody extends StatefulWidget {
  const BasketBody({super.key, required this.providerID});
  final String providerID;
  @override
  State<BasketBody> createState() => _BasketBodyState();
}

class _BasketBodyState extends State<BasketBody> {
  late List<BasketModel> basketItems;
  bool _isLoading = false;
  int totalBill = 0;

  @override
  void initState() {
    super.initState();
    basketItems = BasketStorage.getItemsByProvider(widget.providerID);

    totalBill =
        basketItems.fold(0, (sum, item) => sum + (item.price * item.count));
  }

  void removeItem(int index) async {
    String itemId = basketItems[index].id;
    await BasketStorage.removeFromBasket(itemId);

    setState(() {
      basketItems.removeAt(index);
    });
  }

  Future<void> _order() async {
    setState(() {
      _isLoading = true;
    });

    List<String> postIDs =
        basketItems.expand((item) => List.filled(item.count, item.id)).toList();
    int totalPrice =
        basketItems.fold(0, (sum, item) => sum + (item.price * item.count));

    try {
      // final response = await Dio().post(
      //   'https://192.168.1.17/api/v1/orders/create-order',
      //   data: {
      //     'providerID': widget.providerID,
      //     'postID': postIDs,
      //     'description': 'description4',
      //     'price': totalPrice,
      //   },
      //   options:
      //       Options(headers: {'Authorization': 'Bearer ${Data.user.token}'}),
      // );

      basketItems.clear();
      totalBill = 0;
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   print("Order created successfully");
      // } else {
      //   print("Error creating order: ${response.data}");
      // }
    } catch (e) {
      if (e is DioException) {
        print(e.response?.data);
      } else {
        print("Error creating order: $e");
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
        TotalBill(
          totalBill: totalBill,
          onTap: _isLoading ? () {} : _order,
          isLoading: _isLoading,
        ),
      ],
    );
  }
}
