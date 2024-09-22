import 'package:flutter/material.dart';
import 'package:taht_bety/core/utils/styles.dart';
import 'package:taht_bety/user/Features/Home/widgets/custtom_search_container.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search',
          style: Styles.title24Bold,
        ),
        centerTitle: true,
        leading: const Padding(
          padding: EdgeInsets.only(left: 26),
          child: Icon(
            Icons.arrow_back_ios,
            size: 35,
          ),
        ),
      ),
      body: const CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  EdgeInsets.only(top: 32, left: 16, right: 16, bottom: 16),
              child: CusttomSearchContainer(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recent",
                    style: Styles.subtitle16Bold,
                  ),
                  Text(
                    "Clear All",
                    style: Styles.text16SemiBold,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
