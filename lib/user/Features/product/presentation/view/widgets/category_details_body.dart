import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety/core/utils/app_router.dart';
import 'package:taht_bety/user/Features/product/presentation/view/widgets/item_product_card.dart';
import 'package:taht_bety/user/Features/profile/data/models/provider_model/post.dart';

class CategoryDetailsBody extends StatefulWidget {
  final List<Post> products;
  final String category;

  const CategoryDetailsBody({
    super.key,
    required this.products,
    required this.category,
  });

  @override
  State<CategoryDetailsBody> createState() => _CategoryDetailsBodyState();
}

class _CategoryDetailsBodyState extends State<CategoryDetailsBody> {
  late List<Post> filteredProducts;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredProducts = widget.products; // في البداية، عرض جميع المنتجات
  }

  void _filterProducts(String query) {
    setState(() {
      searchQuery = query;
      filteredProducts = widget.products
          .where((product) =>
              product.title != null &&
              product.title!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category, // عرض اسم الفئة
          style: const TextStyle(fontWeight: FontWeight.bold),
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
              if (context.canPop()) {
                context.pop();
              } else {
                context.go(AppRouter.kHomePage);
              }
            },
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for a product...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onChanged: (query) {
                _filterProducts(query);
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(
                  filteredProducts.length,
                  (index) => GestureDetector(
                    onTap: () {
                      context.push(
                        AppRouter.kProductDetails,
                        extra: filteredProducts[index],
                      );
                    },
                    child: ItemProductCard(
                      post: filteredProducts[index],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
