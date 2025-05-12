import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:taht_bety/auth/data/models/curuser.dart';
import 'package:taht_bety/auth/data/models/user_strorge.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/utils/styles.dart';
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
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    basketItems = BasketStorage.getItemsByProvider(widget.providerID);

    totalBill =
        basketItems.fold(0, (sum, item) => sum + (item.price * item.count));
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
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
    CurUser user = UserStorage.getUserData();
    List<String> postIDs =
        basketItems.expand((item) => List.filled(item.count, item.id)).toList();
    int totalPrice =
        basketItems.fold(0, (sum, item) => sum + (item.price * item.count));

    final orderData = {
      'providerID': widget.providerID,
      'postID': postIDs,
      'price': totalPrice,
      'description': _descriptionController.text.isNotEmpty
          ? _descriptionController.text
          : 'Order from Taht Bety',
    };
    try {
      final response = await Dio().post(
        '${kBaseUrl}orders/create-order',
        data: orderData,
        options: Options(
          headers: {'Authorization': 'Bearer ${user.token}'},
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Order created successfully"),
            duration: Duration(seconds: 3),
          ),
        );
        basketItems.clear();
        totalBill = 0;
        _descriptionController.clear();
      } else {
        print("Error creating order: ${response.data}");
      }
    } catch (e) {
      if (e is DioException) {
        print("Dio error: ${e.response?.data}");
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
        const Text(
          "To delete an item, swipe it to the left",
          style: Styles.text12Light,
        ),
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextField(
            controller: _descriptionController,
            maxLines: 2,
            decoration: InputDecoration(
              hintText: "Add a description for your order...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
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
