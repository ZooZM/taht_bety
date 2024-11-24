import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/utils/styles.dart';
import 'package:taht_bety/user/Features/profile/presentation/widgets/product_card.dart';
import 'package:taht_bety/user/Features/profile/presentation/widgets/serv_profile_appbar.dart';
import 'package:taht_bety/user/Features/profile/presentation/widgets/serv_upper_widget.dart';

class ServiceProfileBody extends StatelessWidget {
  const ServiceProfileBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const SliverToBoxAdapter(
              child: ServUpperWidget(),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 12,
              ),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: Text(
                  "Proudcts",
                  style: Styles.subtitle18Bold,
                ),
              ),
            ),
            SliverFillRemaining(
              child: Expanded(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Column(
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                        child: ProductCard(),
                      ),
                      Container(
                        height: 1,
                        color: Colors.black26,
                      )
                    ],
                  ),
                  itemCount: 5,
                ),
              ),
            )
          ],
        ),
        Positioned(
          bottom: 16,
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
      ],
    );
  }
}
