import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/utils/app_router.dart';
import 'package:taht_bety/core/utils/styles.dart';
import 'package:taht_bety/user/Features/product/data/basket_model.dart';
import 'package:taht_bety/user/Features/product/data/basket_storage.dart';
import 'package:taht_bety/user/Features/profile/data/models/provider_model/provider_model.dart';
import 'package:taht_bety/user/Features/profile/presentation/widgets/product_card.dart';
import 'package:taht_bety/user/Features/profile/presentation/widgets/serv_profile_appbar.dart';
import 'package:taht_bety/user/Features/profile/presentation/widgets/serv_upper_widget.dart';
import 'package:taht_bety/user/Features/profile/presentation/widgets/view_basket.dart';
import 'package:taht_bety/user/Features/profile/presentation/widgets/review_section_widget.dart';

class ServiceProfileBodyF extends StatefulWidget {
  const ServiceProfileBodyF({
    super.key,
    required this.provider,
  });
  final ProviderModel provider;

  static int nStars = 0;
  @override
  State<ServiceProfileBodyF> createState() => _ServiceProfileBodyFState();
}

class _ServiceProfileBodyFState extends State<ServiceProfileBodyF> {
  late List<BasketModel> basket;
  int totalPrice = 0;
  final TextEditingController _reviewController = TextEditingController();
  bool reviewLoading = false;

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
    return Stack(
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
              const SizedBox(
                height: 12,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Text(
                  "Products",
                  style: Styles.subtitle18Bold,
                ),
              ),
              Column(
                children: List.generate(
                  widget.provider.posts!.length,
                  (index) => Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.push(
                            AppRouter.kProductDetails,
                            extra: widget.provider.posts![index],
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 18),
                          child:
                              ProductCard(post: widget.provider.posts![index]),
                        ),
                      ),
                      Container(height: 1, color: Colors.black26),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ReviewSectionWidget(
                  providerId: widget.provider.providerId!,
                  reviews: widget.provider.reviews!,
                ),
              ),
              const SizedBox(height: 300),
            ],
          ),
        ),
        Positioned(
          bottom: 55,
          left: 16,
          child: InkWell(
            onTap: () {
              context.push(AppRouter.kChatProvider);
            },
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
    );
  }
}
