import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taht_bety/auth/data/models/user_strorge.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/utils/api_service.dart';
import 'package:taht_bety/core/utils/styles.dart';
import 'package:taht_bety/core/widgets/custom_cushed_image.dart';
import 'package:taht_bety/user/Features/order/data/models/order_model/order_model.dart';
import 'package:taht_bety/user/Features/order/presentation/cubit/order_cubit.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  final String category;

  const OrderCard({super.key, required this.order, required this.category});

  Future<void> _cancelOrder(BuildContext context) async {
    try {
      final user = UserStorage.getUserData();
      final dio = Dio();
      final response = await ApiService(dio).patch(
        endPoint: 'orders/cancel-order/${order.id}',
        token: user.token,
      );

      if (response['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Order canceled successfully"),
          ),
        );
        context.read<OrderCubit>().fetchOrders();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to cancel the order"),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${e.toString()}"),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomCushedImage(
              image: order.providerId?.photo ?? '', height: 80, width: 80),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order: ${order.id}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  order.description ?? 'Unknown Provider',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  order.providerId?.name ?? 'Unknown Provider',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
          Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Text(
                "${order.price.toString()} EGP",
                style: Styles.text16SemiBold.copyWith(
                  color: kPrimaryColor,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              order.status != 'canceled'
                  ? GestureDetector(
                      onTap: () async {
                        await _cancelOrder(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        ],
      ),
    );
  }
}
