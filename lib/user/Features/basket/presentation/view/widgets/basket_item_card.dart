import 'package:flutter/material.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/user/Features/product/data/basket_model.dart';

class BasketItemCard extends StatelessWidget {
  final BasketModel item;
  final VoidCallback onRemove;
  final VoidCallback onAdd;
  final VoidCallback onDelete;

  const BasketItemCard({
    super.key,
    required this.item,
    required this.onRemove,
    required this.onAdd,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Dismissible(
        key: Key(item.id),
        direction: DismissDirection.startToEnd,
        background: Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: ksecondryColor,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Icon(Icons.delete, color: Colors.white, size: 30),
        ),
        onDismissed: (direction) {
          onDelete();
        },
        child: ListTile(
          leading: Image.network(item.image, width: 50, height: 50),
          title: Text(item.id),
          subtitle: Text("${item.price} EGP"),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: onRemove,
              ),
              Text(item.count.toString(), style: const TextStyle(fontSize: 16)),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: onAdd,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
