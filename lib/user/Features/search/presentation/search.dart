import 'package:flutter/material.dart';
import 'package:taht_bety/core/utils/styles.dart';
import 'package:taht_bety/user/Features/search/presentation/widget/search_body.dart';

class Search extends StatelessWidget {
  const Search({super.key, required this.onPressFun});
  final void Function() onPressFun;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Search',
            style: Styles.title24Bold,
          ),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: IconButton(
              iconSize: 35,
              icon: const Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: onPressFun,
            ),
          ),
        ),
        body: const SearchBody(),
      ),
    );
  }
}
