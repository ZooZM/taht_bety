import 'package:flutter/material.dart';
import 'order_card.dart';
import 'order_class.dart';

class OrderListView extends StatelessWidget {
  const OrderListView({
    super.key,
    required this.orders,
    required this.tabs,
    required int selectedIndex,
  }) : _selectedIndex = selectedIndex;

  final Map<String, List<Order>> orders;
  final List<String> tabs;
  final int _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders[tabs[_selectedIndex]]!.length,
      itemBuilder: (context, index) {
        Order order = orders[tabs[_selectedIndex]]![index];
        return OrderCard(order: order, category: tabs[_selectedIndex]);
      },
    );
  }
}
