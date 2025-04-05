import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety/core/utils/app_router.dart';

import '../../../../../constants.dart';
import '../../../../../core/utils/styles.dart';
import '../../../profile/data/models/provider_model/post.dart';
import 'product_details_widget.dart';
import 'widgets/product_details_body.dart';

class CategoryDetailsScreen extends StatelessWidget {
  final List<Post> products = [
    Post(
        id: "1",
        title: "Milk",
        price: 10,
        content: "Fresh milk from local farms.",
        images: ["assets/images/milk.jpg"],
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        updatedAt: DateTime.now(),
        isMainService: false,
        providerId: "20"),
    Post(
        id: "1",
        title: "Milk",
        price: 10,
        content: "Fresh milk from local farms.",
        images: ["assets/images/milk.jpg"],
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        updatedAt: DateTime.now(),
        isMainService: false,
        providerId: "20"),
    Post(
        id: "1",
        title: "Milk",
        price: 10,
        content: "Fresh milk from local farms.",
        images: ["assets/images/milk.jpg"],
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        updatedAt: DateTime.now(),
        isMainService: false,
        providerId: "20"),
    Post(
        id: "1",
        title: "Milk",
        price: 10,
        content: "Fresh milk from local farms.",
        images: ["assets/images/milk.jpg"],
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        updatedAt: DateTime.now(),
        isMainService: false,
        providerId: "20"),
    Post(
        id: "1",
        title: "Milk",
        price: 10,
        content: "Fresh milk from local farms.",
        images: ["assets/images/milk.jpg"],
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        updatedAt: DateTime.now(),
        isMainService: false,
        providerId: "20"),
  ];

  CategoryDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Milk",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: Container(
            margin: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(25),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          actions: [
            Container(
              margin:
                  const EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(25),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(5),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8, // Adjusted for new layout
              crossAxisSpacing: 5,
              mainAxisSpacing: 1,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      settings: RouteSettings(arguments: products[index]),
                      builder: (context) => ProductDetailsWidget(),
                    ),
                  );
                },
                child: ItemProductCard(
                  productName: products[index].title ?? 'Unknown Product',
                  price: products[index].price.toString(),
                  imagePath: products[index].images!.isNotEmpty
                      ? products[index].images![0]
                      : 'assets/images/milk.jpg',
                  count:
                      0, // Replace with the actual count property if available
                ),
              );
            },
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: ksecondryColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 1),
                      child: Text(
                        "0", // Replace with your count variable
                        style:
                            Styles.text14Light.copyWith(color: ksecondryColor),
                      ),
                    ),
                  ),
                  Text(
                    " View basket",
                    style: Styles.text14Light.copyWith(color: Colors.white),
                  ),
                  const Spacer(),
                  Text(
                    "0.00EGP", // Replace with your price variable
                    style: Styles.text14Light.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class ItemProductCard extends StatelessWidget {
  final String productName;
  final String price;
  final String imagePath;
  final int count;

  const ItemProductCard({
    super.key,
    required this.productName,
    required this.price,
    required this.imagePath,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Add button positioned behind the image
        Positioned(
          top: 90,
          right: 30,
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.add, size: 18),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () {},
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image container with border
              Container(
                height: 120, // Increased height for better visibility
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(imagePath, fit: BoxFit.contain),
                ),
              ),
              const SizedBox(height: 12),
              // Product details below the image border
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      price,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
