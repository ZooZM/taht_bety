import 'package:flutter/material.dart';
import 'package:taht_bety/core/widgets/custom_cushed_image.dart';
import 'package:taht_bety/user/Features/product/data/basket_storage.dart';
import 'package:taht_bety/user/Features/profile/data/models/provider_model/post.dart';

class ItemProductCard extends StatefulWidget {
  final Post post;

  const ItemProductCard({
    super.key,
    required this.post,
  });

  @override
  State<ItemProductCard> createState() => _ItemProductCardState();
}

class _ItemProductCardState extends State<ItemProductCard> {
  bool addToBasket = false;
  @override
  void initState() {
    final item = BasketStorage.getBasketItem(widget.post.id ?? '');
    if (item != null) {
      setState(() {
        addToBasket = true;
      });
    } else {
      setState(() {
        addToBasket = false;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 16),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image container with add button overlay
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CustomCushedImage(
                  image: widget.post.images != null &&
                          widget.post.images!.isNotEmpty
                      ? widget.post.images![0]
                      : 'assets/images/placeholder.png', // صورة افتراضية إذا لم تكن هناك صور
                  height: 120,
                  width: double.infinity,
                  isImage: true,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildAddButton(),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Product information
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.post.title ?? 'Unknown Product',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${widget.post.price ?? 0} EGP',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.9),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(
          addToBasket ? Icons.delete : Icons.add,
          size: 18,
        ),
        padding: EdgeInsets.zero,
        onPressed: () {
          if (addToBasket) {
            BasketStorage.removeFromBasket(widget.post.id ?? '');
          } else {
            BasketStorage.addToBasket(
              id: widget.post.id ?? '',
              image:
                  widget.post.images != null && widget.post.images!.isNotEmpty
                      ? widget.post.images![0]
                      : '', // صورة افتراضية
              count: 1,

              providerId: widget.post.providerId ?? '',
              price: widget.post.price ?? 0,
              title: widget.post.title ?? 'Unknown Product',
              description: widget.post.content ?? 'No description available',
            );
          }
          setState(() {
            addToBasket = !addToBasket;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                addToBasket ? 'Added to basket' : 'Removed from basket',
              ),
              duration: const Duration(seconds: 1),
            ),
          );
        },
      ),
    );
  }
}
