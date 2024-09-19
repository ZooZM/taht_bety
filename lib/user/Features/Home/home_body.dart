import 'package:flutter/material.dart';
import 'package:taht_bety/user/Features/Home/widgets/categories_list.dart';
import 'package:taht_bety/user/Features/Home/widgets/item_list.dart';
import 'package:taht_bety/user/Features/Home/widgets/upper_widget_home.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: UpperWidgetHome(),
              ),
              CategoriesList(),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
        ItemsList()
      ],
    );
  }
}
