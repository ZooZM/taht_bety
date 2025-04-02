import 'package:flutter/material.dart';
import 'package:taht_bety/user/Features/order/data/models/order_model/order_model.dart';
import 'order_card.dart';

class OrderListView extends StatelessWidget {
  const OrderListView({
    super.key,
    required this.orders,
    required this.tabs,
    required int selectedIndex,
  }) : _selectedIndex = selectedIndex;

  final Map<String, List<OrderModel>> orders;
  final List<String> tabs;
  final int _selectedIndex;

  @override
  Widget build(BuildContext context) {
    final List<OrderModel> selectedOrders = orders[tabs[_selectedIndex]] ?? [];

    if (selectedOrders.isEmpty) {
      return const Center(
        child: Text('No orders available'),
      );
    }

    return ListView.builder(
      itemCount: selectedOrders.length,
      itemBuilder: (context, index) {
        OrderModel order = selectedOrders[index];
        return OrderCard(order: order, category: tabs[_selectedIndex]);
      },
    );
  }
}
