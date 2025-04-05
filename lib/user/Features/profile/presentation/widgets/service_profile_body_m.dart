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
import 'package:taht_bety/user/Features/profile/presentation/widgets/product_card.dart';
import 'package:taht_bety/user/Features/profile/presentation/widgets/serv_profile_appbar.dart';
import 'package:taht_bety/user/Features/profile/presentation/widgets/serv_upper_widget.dart';
import 'package:taht_bety/user/Features/profile/presentation/widgets/view_basket.dart';

class ServiceProfileBodyM extends StatefulWidget {
  ServiceProfileBodyM({
    super.key,
  });
  final ProviderModel provider = ProviderModel.fromJson({
    "_id": "67a9593865bff1fbf799b076",
    "providerID": {
      "_id": "67a9590165bff1fbf799b071",
      "name": "Pizza King",
      "email": "salllllma5@gmail.com",
      "photo":
          "https://images.zyda.co/cdn-cgi/image/width=640,quality=75,f=auto,metadata=none/photos/restaurants/logo_urls/4872/original/asaSAss-removebg-preview.png?1679832509"
    },
    "providerType": "F-Restaurants",
    "id": ["image15.jpg", "image16.jpg"],
    "criminalRecord": "Clearance8.pdf",
    "subscriptionType": "percentage",
    "subscriptionStartDate": "2023-07-08T00:00:00.000Z",
    "subscriptionEndDate": "2024-07-08T00:00:00.000Z",
    "subscriptionPercentage": 15,
    "subscriptionMonthly": null,
    "isActive": true,
    "isOnline": false,
    "reports": [],
    "locations": [
      {
        "coordinates": {
          "type": "Point",
          "coordinates": [30.158096999195767, 31.64406864903742]
        },
        "address": "Al shorouq city, el shouhada road, Pizza king",
        "_id": "67a9593865bff1fbf799b077",
        "id": "67a9593865bff1fbf799b077"
      }
    ],
    "lastPhotoAt": "2025-02-10T01:41:12.338Z",
    "__v": 7,
    "bookedAppointments": [],
    "reviews": [
      {
        "_id": "67c7d99d6cdb162b6f511428",
        "review": "Great restaurant",
        "rating": 4,
        "user": {
          "_id": "67c7a75c094463c0cfbbb7d5",
          "name": "mostafa taha",
          "email": "mostafa@gmail.com"
        },
        "provider": "67a9590165bff1fbf799b071",
        "id": "67c7d99d6cdb162b6f511428"
      },
      {
        "_id": "67e32cc6b9465de6b05b7938",
        "review": "جامد",
        "rating": 4,
        "user": {
          "_id": "67c86757a6acd2b4153cf902",
          "name": "Zeyad",
          "email": "zeyadmostafa201@gmail.com",
          "photo":
              "https://static.vecteezy.com/system/resources/previews/045/615/806/non_2x/a-labor-construction-worker-isolated-on-transparent-background-png.png"
        },
        "provider": "67a9590165bff1fbf799b071",
        "__v": 0,
        "id": "67e32cc6b9465de6b05b7938"
      }
    ],
    "posts": [
      {
        "_id": "67a9596765bff1fbf799b07e",
        "providerID": "67a9590165bff1fbf799b071",
        "images": [
          "https://images.deliveryhero.io/image/talabat/Menuitems/chickenranch637785608831733012.jpg?width=172&height=172"
        ],
        "title": "Chicken Kingdom",
        "content":
            "Marinated chicken, mushroom, jalapeno, tomato, and ranch sauce, stuffed crust with cheddar cheese and mozzarella cheese.",
        "price": 286
      },
      {
        "_id": "67a9597d65bff1fbf799b084",
        "providerID": "67a9590165bff1fbf799b071",
        "images": [
          "https://images.deliveryhero.io/image/talabat/Menuitems/chickenranch637785608831733012.jpg?width=172&height=172"
        ],
        "title": "Chicken King",
        "content":
            "Marinated chicken, mushroom, jalapeno, tomato, and ranch sauce, stuffed crust with cheddar cheese and mozzarella cheese.",
        "price": 286
      },
      {
        "_id": "67a9599965bff1fbf799b08c",
        "providerID": "67a9590165bff1fbf799b071",
        "images": [
          "https://images.deliveryhero.io/image/talabat/Menuitems/chickenranch637785608868217730.jpg?width=172&height=172"
        ],
        "title": "Chicken Kingdom",
        "content":
            "Marinated chicken, mushroom, tomatoes, jalapeno and ranch sauce, stuffed crust with cheddar cheese and mozzarella cheese.",
        "price": 214
      },
      {
        "_id": "67a959b065bff1fbf799b092",
        "providerID": "67a9590165bff1fbf799b071",
        "images": [
          "https://images.deliveryhero.io/image/talabat/Menuitems/Chicken_BBQ_Pizza0231638063670811608703.png?width=172&height=172"
        ],
        "title": "Triple King Pizza",
        "content":
            "3 Medium kingdom cheesy bites pizzas with large salad dish and drink liter of your choice.",
        "price": 643
      },
      {
        "_id": "67a959ca65bff1fbf799b098",
        "providerID": "67a9590165bff1fbf799b071",
        "images": [
          "https://images.deliveryhero.io/image/talabat/Menuitems/%D8%B9%D8%B1%D8%B6_%D9%83%D9%8A%D9%86%D8%AC%D8%AF%D9%85_%D9%83%D8%A8%D9%8A%D8%B1_1638148297605637483.jpg?width=172&height=172"
        ],
        "title": "Kingdom Pizza Offer",
        "content": "Served with drink liter of your choice.",
        "price": 302
      },
      {
        "_id": "67a959e865bff1fbf799b09e",
        "providerID": "67a9590165bff1fbf799b071",
        "images": [
          "https://images.deliveryhero.io/image/talabat/Menuitems/Chicken_BBQ_Pizza022638063648800171712.png?width=172&height=172"
        ],
        "title": "Combo Crust Offer",
        "content":
            "Large pizza with cheesy bites stuffed crust, medium pizza with cheesy bites edges and drink liter of your choice.",
        "price": 479
      },
      {
        "_id": "67a959fc65bff1fbf799b0a4",
        "providerID": "67a9590165bff1fbf799b071",
        "images": [
          "https://images.deliveryhero.io/image/talabat/Menuitems/%D8%B9%D8%B1%D8%B6_%D9%83%D9%8A%D9%86%D8%AC%D8%AF%D9%85_%D9%83%D8%A8%D9%8A%D8%B1_1638148297605637483.jpg?width=172&height=172"
        ],
        "title": "Meal Beverage Offer",
        "content":
            "Your choice of medium kingdom pizza, 1 medium salad and drink of your choice.",
        "price": 242
      }
    ]
  });
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
  final List<String> categories = [
    'Category 1',
    'Category 2',
    'Category 3',
    'Category 4',
    'Category 5',
    'Category 6',
    'Category 7',
    'Category 8',
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
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                        return Column(
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
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  categories[index],
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
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            child: ServProfileAppBar(),
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
