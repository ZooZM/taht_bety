import 'package:flutter/material.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/user/Features/product/presentation/view/widgets/add_to_basket_widget.dart';
import 'package:taht_bety/user/Features/product/presentation/view/widgets/food_image_widget.dart';
import 'package:taht_bety/user/Features/product/presentation/view/widgets/food_info_widget.dart';
import 'package:taht_bety/user/Features/product/data/basket_storage.dart';
import 'package:taht_bety/user/Features/profile/data/models/provider_model/post.dart';

class ProductDetailsBody extends StatefulWidget {
  const ProductDetailsBody({
    super.key,
    required this.post,
  });
  final Post post;

  @override
  State<ProductDetailsBody> createState() => _ProductDetailsBodyState();
}

class _ProductDetailsBodyState extends State<ProductDetailsBody> {
  int count = 1;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FoodImageWidget(
                  image: widget.post.images![0],
                ),
                const SizedBox(height: 12),
                FoodInfoWidget(
                  price: widget.post.price.toString(),
                  description: widget.post.content!,
                  title: widget.post.title!,
                  plusCallback: () {
                    setState(() {
                      count++;
                    });
                  },
                  minusCallback: () {
                    setState(() {
                      if (count > 1) {
                        count--;
                      }
                    });
                  },
                  itemCount: count,
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 5,
          right: 0,
          left: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AddToBasketWidget(
              price: widget.post.price.toString(),
              onTap: () async {
                setState(() {
                  isLoading = true;
                });
                await BasketStorage.addToBasket(
                  id: widget.post.id!,
                  image: widget.post.images![0],
                  count: count,
                  providerId: widget.post.providerId!,
                  price: widget.post.price!,
                  title: widget.post.title!,
                );
                setState(() {
                  isLoading = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Added to basket')),
                );
              },
              isLoading: isLoading,
            ),
          ),
        ),
        Positioned(
          top: 5,
          left: 16,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: kWhite,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 1,
                )
              ],
            ),
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 30,
                )),
          ),
        ),
      ],
    );
  }
}
