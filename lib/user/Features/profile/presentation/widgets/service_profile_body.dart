import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/utils/app_router.dart';
import 'package:taht_bety/core/utils/styles.dart';
import 'package:taht_bety/core/widgets/custom_cushed_image.dart';
import 'package:taht_bety/user/Features/Home/data/models/provider_model/provider_model.dart';
import 'package:taht_bety/user/Features/product/data/basket_model.dart';
import 'package:taht_bety/user/Features/product/data/basket_storage.dart';
import 'package:taht_bety/user/Features/profile/presentation/widgets/product_card.dart';
import 'package:taht_bety/user/Features/profile/presentation/widgets/serv_profile_appbar.dart';
import 'package:taht_bety/user/Features/profile/presentation/widgets/serv_upper_widget.dart';
import 'package:taht_bety/user/Features/profile/presentation/widgets/view_basket.dart';

class ServiceProfileBody extends StatefulWidget {
  const ServiceProfileBody({
    super.key,
    required this.provider,
  });
  final ProviderModel provider;

  @override
  State<ServiceProfileBody> createState() => _ServiceProfileBodyState();
}

class _ServiceProfileBodyState extends State<ServiceProfileBody> {
  late List<BasketModel> basket;
  int totalPrice = 0;
  @override
  void initState() {
    basket = BasketStorage.getItemsByProvider(widget.provider.providerId!);
    for (var item in basket) {
      totalPrice += item.price;
    }
    super.initState();
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
                  "Proudcts",
                  style: Styles.subtitle18Bold,
                ),
              ),
              Column(
                children: List.generate(
                  widget.provider.posts!.length,
                  (index) => Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 18),
                        child: ProductCard(post: widget.provider.posts![index]),
                      ),
                      Container(height: 1, color: Colors.black26),
                    ],
                  ),
                ),
              ),
              const FeedbackRatingWidget(),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                child: Text(
                  "Rating & Reviews",
                  style: Styles.subtitle16Bold,
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Reviews(provider: widget.provider),
              ),
              const SizedBox(
                height: 300,
              )
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
              context.push(AppRouter.kBasket, extra: basket);
            },
            count: basket.length,
          ),
        )
      ],
    );
  }
}

class Reviews extends StatelessWidget {
  const Reviews({
    super.key,
    required this.provider,
  });

  final ProviderModel provider;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          children: [
            Row(
              children: [
                CustomCushedImage(
                  image:
                      provider.photo?.isNotEmpty == true ? provider.photo! : '',
                  height: 50,
                  width: 50,
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  'Ahmed Ali',
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
                  children: List.generate(
                    5,
                    (index) => const Icon(
                      Icons.star_border_outlined,
                      color: ksecondryColor,
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  '23/2/2025',
                  style: Styles.text12Light.copyWith(
                    color: ksecondryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magnaconsectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magnaconsectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna',
              style: Styles.text12Light.copyWith(
                color: ksecondryColor,
              ),
              softWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}

class FeedbackRatingWidget extends StatelessWidget {
  const FeedbackRatingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Text(
            "Rate This Provider",
            style: Styles.subtitle18Bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              5,
              (index) => IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.star_border_outlined,
                  color: ksecondryColor,
                  size: 35,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
