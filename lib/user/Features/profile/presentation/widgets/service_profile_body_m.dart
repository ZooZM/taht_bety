import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart';
import 'package:taht_bety/auth/data/models/user_strorge.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/utils/app_router.dart';
import 'package:taht_bety/core/utils/styles.dart';
import 'package:taht_bety/core/widgets/custom_cushed_image.dart';
import 'package:taht_bety/user/Features/product/data/basket_model.dart';
import 'package:taht_bety/user/Features/product/data/basket_storage.dart';
import 'package:taht_bety/user/Features/profile/data/models/provider_model/provider_model.dart';
import 'package:taht_bety/user/Features/profile/data/models/provider_model/review.dart';
import 'package:taht_bety/user/Features/profile/presentation/widgets/serv_profile_appbar.dart';
import 'package:taht_bety/user/Features/profile/presentation/widgets/serv_upper_widget.dart';
import 'package:taht_bety/user/Features/profile/presentation/widgets/view_basket.dart';

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
  int _rating = 0;
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

  Future<void> _submitReview() async {
    setState(() {
      reviewLoading = true;
    });
    final user = UserStorage.getUserData();
    final reviewText = _reviewController.text;

    if (reviewText.isNotEmpty && _rating > 0) {
      try {
        final response = await Dio().post(
          '${kBaseUrl}reviews',
          data: {
            'review': reviewText,
            'rating': _rating,
            'provider': widget.provider.providerId,
          },
          options: Options(
            headers: {'Authorization': 'Bearer ${user.token}'},
          ),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          final user = UserStorage.getUserData();
          final review = Review(
            user: ReviewUser(
              name: user.name,
              photo: user.photo,
              id: user.userId,
            ),
            review: reviewText,
            rating: _rating,
            createdAt: DateTime.now(),
            id: response.data['data']['_id'],
            provider: widget.provider.providerId,
            updatedAt: DateTime.now(),
          );
          _reviewController.clear();
          setState(() {
            _rating = 0;
            widget.provider.reviews!.add(review);
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("please give a Rating and Review"),
              duration: Duration(seconds: 5),
            ),
          );
        }
      } on DioException catch (e) {
        String errorMessage = 'An error occurred during review submission';
        if (e.response != null && e.response!.data is Map<String, dynamic>) {
          errorMessage = e.response!.data['message'] ?? errorMessage;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            duration: const Duration(seconds: 10),
          ),
        );
      }
    }
    setState(() {
      reviewLoading = false;
    });
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
                        const Text(
                          "Write a Review",
                          style: Styles.subtitle16Bold,
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _reviewController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText: "Write your review here...",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: List.generate(
                            5,
                            (index) => IconButton(
                              icon: Icon(
                                index < _rating
                                    ? Icons.star
                                    : Icons.star_border_outlined,
                                color: ksecondryColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  _rating = index + 1;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: reviewLoading
                                ? ksecondryColor.withOpacity(0.2)
                                : ksecondryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: reviewLoading ? () {} : _submitReview,
                          child: const Text(
                            "Submit Review",
                            style: TextStyle(color: kWhite),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 16),
                          child: Text(
                            "Rating & Reviews",
                            style: Styles.subtitle16Bold,
                          ),
                        ),
                        ListView.builder(
                          itemCount: widget.provider.reviews!.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CustomCushedImage(
                                      image: widget.provider.reviews![index]
                                                  .user?.photo?.isNotEmpty ==
                                              true
                                          ? widget.provider.reviews![index]
                                              .user!.photo!
                                          : '',
                                      height: 50,
                                      width: 50,
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Text(
                                      widget
                                          .provider.reviews![index].user!.name!,
                                      style: Styles.text14Light.copyWith(
                                        color: ksecondryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: List.generate(5, (starIndex) {
                                        return Icon(
                                          starIndex >=
                                                  widget.provider
                                                      .reviews![index].rating!
                                              ? Icons.star_border
                                              : Icons.star,
                                          color: ksecondryColor,
                                          size: 24,
                                        );
                                      }),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  widget.provider.reviews![index].review!,
                                  style: Styles.text12Light.copyWith(
                                    color: ksecondryColor,
                                  ),
                                  softWrap: true,
                                ),
                              ],
                            ),
                          ),
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
