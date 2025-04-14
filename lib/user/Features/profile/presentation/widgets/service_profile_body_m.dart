import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/utils/app_router.dart';
import 'package:taht_bety/core/utils/styles.dart';
import 'package:taht_bety/user/Features/product/data/basket_model.dart';
import 'package:taht_bety/user/Features/product/data/basket_storage.dart';
import 'package:taht_bety/user/Features/profile/data/models/provider_model/provider_model.dart';
import 'package:taht_bety/user/Features/profile/presentation/widgets/serv_profile_appbar.dart';
import 'package:taht_bety/user/Features/profile/presentation/widgets/serv_upper_widget.dart';
import 'package:taht_bety/user/Features/profile/presentation/widgets/view_basket.dart';
import 'package:taht_bety/user/Features/profile/presentation/widgets/review_section_widget.dart';

class ServiceProfileBodyM extends StatefulWidget {
  ServiceProfileBodyM({
    super.key,
    required this.provider,
  });
  final ProviderModel provider;
  static int nStars = 0;
  @override
  State<ServiceProfileBodyM> createState() => _ServiceProfileBodyMState();
}

class _ServiceProfileBodyMState extends State<ServiceProfileBodyM> {
  late List<BasketModel> basket;
  int totalPrice = 0;
  final TextEditingController _reviewController = TextEditingController();
  bool reviewLoading = false;

  // Sample categories data - you can replace with your actual data
  final List<Map<String, String>> categories = [
    {'name': 'Bakery', 'image': '${kBaseCategoryAssets}bakery.png'},
    {'name': 'Beverages', 'image': '${kBaseCategoryAssets}beverages.png'},
    {'name': 'Canned Food', 'image': '${kBaseCategoryAssets}cannedfood.png'},
    {'name': 'Cheese', 'image': '${kBaseCategoryAssets}cheese.png'},
    {
      'name': 'Cleaning Supplies',
      'image': '${kBaseCategoryAssets}cleaningsupplies.png'
    },
    {'name': 'Cold Cuts', 'image': '${kBaseCategoryAssets}coldcuts.png'},
    {'name': 'Dairy & Eggs', 'image': '${kBaseCategoryAssets}dairy&eggs.png'},
    {'name': 'Fish', 'image': '${kBaseCategoryAssets}fish.png'},
    {'name': 'Frozen Food', 'image': '${kBaseCategoryAssets}frozenfood.png'},
    {
      'name': 'Fruits & Vegetables',
      'image': '${kBaseCategoryAssets}fruits&vegetables.png'
    },
    {'name': 'Groceries', 'image': '${kBaseCategoryAssets}groceries.png'},
    {
      'name': 'Herbs & Spices',
      'image': '${kBaseCategoryAssets}herbs&spices.png'
    },
    {
      'name': 'Meat & Poultry',
      'image': '${kBaseCategoryAssets}meat&poultry.png'
    },
    {'name': 'Nuts & Seeds', 'image': '${kBaseCategoryAssets}nuts&seeds.png'},
    {
      'name': 'Personal Care & Cosmetics',
      'image': '${kBaseCategoryAssets}personalcare&cosmetics.png'
    },
  ];

  @override
  void initState() {
    basket = BasketStorage.getItemsByProvider(widget.provider.providerId!);
    for (var item in basket) {
      totalPrice += item.price * item.count;
    }
    super.initState();
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ServUpperWidget(
                  image: widget.provider.photo?.isNotEmpty == true
                      ? widget.provider.photo!
                      : '',
                  address: widget.provider.locations![0].address!,
                  name: widget.provider.name!,
                ),
                const SizedBox(height: 12),

                // Add the Categories section here
                const Padding(
                  padding: EdgeInsets.only(left: 16, top: 8),
                  child: Text(
                    "Shop by categories",
                    style: Styles.subtitle18Bold,
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.28,
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of rows
                        mainAxisSpacing: 5, // Vertical spacing between rows
                        crossAxisSpacing: 5, // Horizontal spacing between items
                        childAspectRatio:
                            0.8, // Width/height ratio (wider than tall)
                      ),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // Handle category tap
                            context.push(
                              AppRouter.kCategoryDetail,
                              extra: {
                                'category': categories[index]['name'],
                                'posts': widget.provider.posts,
                              },
                            );
                          },
                          child: Column(
                            children: [
                              Container(
                                width: 100,
                                height: MediaQuery.of(context).size.height *
                                    0.28 *
                                    0.25,
                                decoration: BoxDecoration(
                                  color: const Color(0xffcfd9e9),
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    categories[index]['image']!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    categories[index]['name']!,
                                    style: Styles.text14Medium.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),

                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReviewSectionWidget(
                          providerId: widget.provider.providerId!,
                          reviews: widget.provider.reviews!,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 300),
              ],
            ),
          ),
          Positioned(
            bottom: 55,
            left: 16,
            child: Container(
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: ksecondryColor,
              ),
              child: const Icon(
                FontAwesomeIcons.comments,
                color: kWhite,
                size: 35,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            child: ServProfileAppBar(
              providerID: widget.provider.providerId!,
              providerModel: widget.provider,
            ),
          ),
          Positioned(
            bottom: 5,
            right: 5,
            left: 5,
            child: ViewBasket(
              price: totalPrice.toString(),
              isLoading: false,
              onTap: () {
                context.push(AppRouter.kBasket,
                    extra: widget.provider.providerId);
              },
              count: basket.length,
            ),
          )
        ],
      ),
    );
  }
}
