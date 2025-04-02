import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:taht_bety/auth/data/models/curuser.dart';
import 'package:taht_bety/auth/data/models/user_strorge.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/user/Features/basket/presentation/view/widgets/basket_item_card.dart';
import 'package:taht_bety/user/Features/basket/presentation/view/widgets/total_bill.dart';
import 'package:taht_bety/user/Features/product/data/basket_model.dart';
import 'package:taht_bety/user/Features/product/data/basket_storage.dart';

class GeneralBasketBody extends StatefulWidget {
  const GeneralBasketBody({super.key, required this.basketItems});
  final List<BasketModel> basketItems;
  @override
  State<GeneralBasketBody> createState() => _GeneralBasketBodyState();
}

class _GeneralBasketBodyState extends State<GeneralBasketBody> {
  bool _isLoading = false;
  int totalBill = 0;
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    totalBill = widget.basketItems
        .fold(0, (sum, item) => sum + (item.price * item.count));
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void removeItem(int index) async {
    String itemId = widget.basketItems[index].id;
    await BasketStorage.removeFromBasket(itemId);

    setState(() {
      widget.basketItems.removeAt(index);
    });
  }

  Future<void> _order(String providerID) async {
    setState(() {
      _isLoading = true;
    });

    try {
      // جلب بيانات المستخدم
      CurUser user = UserStorage.getUserData();

      // إنشاء قائمة `postIDs` بناءً على `basketItems`
      List<String> postIDs = widget.basketItems
          .expand((item) => List.filled(item.count, item.id))
          .toList();

      // حساب السعر الإجمالي
      int totalPrice = widget.basketItems.fold(
        0,
        (sum, item) => sum + (item.price * item.count),
      );

      // إعداد بيانات الطلب
      final orderData = {
        'providerID': providerID,
        'postID': postIDs,
        'price': totalPrice,
        'description': _descriptionController.text.isNotEmpty
            ? _descriptionController.text
            : 'Order from Taht Bety',
      };

      // إرسال الطلب إلى الخادم
      final response = await Dio().post(
        '${kBaseUrl}orders/create-order',
        data: orderData,
        options: Options(
          headers: {'Authorization': 'Bearer ${user.token}'},
        ),
      );

      // التحقق من نجاح الطلب
      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Order created successfully"),
            duration: Duration(seconds: 3),
          ),
        );

        // مسح السلة وإعادة تعيين القيم
        setState(() {
          widget.basketItems.clear();
          totalBill = 0;
          _descriptionController.clear();
        });
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
        Expanded(
          child: ListView.builder(
            itemCount: widget.basketItems.length,
            itemBuilder: (context, index) {
              final item = widget.basketItems[index];

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
          onTap: _isLoading
              ? () {}
              : () async {
                  if (widget.basketItems.isNotEmpty) {
                    setState(() {
                      _isLoading = true;
                    });
                    final basketItemsCopy = List.from(widget.basketItems);
                    for (var item in basketItemsCopy) {
                      await _order(item.providerId);
                    }
                    BasketStorage.clear();
                    setState(() {
                      _isLoading = false;
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Your basket is empty"),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }
                },
          isLoading: _isLoading,
        ),
      ],
    );
  }
}
