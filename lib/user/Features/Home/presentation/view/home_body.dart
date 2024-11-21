import 'package:flutter/material.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/widgets/categories_list.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/widgets/item_list.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/widgets/upper_widget_home.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(
            height: 8,
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: UpperWidgetHome(),
          ),
        ),
        SliverToBoxAdapter(
          child: CategoriesList(),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 16,
          ),
        ),
        ItemsList(),
      ],
    );
  }
}
