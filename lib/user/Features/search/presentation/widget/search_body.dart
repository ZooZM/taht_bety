import 'package:flutter/material.dart';
import 'package:taht_bety/user/Features/search/presentation/widget/recent_state.dart';
import 'package:taht_bety/user/Features/search/presentation/widget/search_itemlist.dart';
import 'package:taht_bety/user/Features/search/presentation/widget/searchbar_ofsearch_body.dart';

class SearchBody extends StatefulWidget {
  const SearchBody({
    super.key,
  });

  @override
  State<SearchBody> createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  bool recentState = true;
  void _onSearchChanged(String value) {
    setState(() {
      recentState = value.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 32, left: 16, right: 16, bottom: 12),
          child: SearchBarOfSearchBody(
            onChange: _onSearchChanged,
          ),
        ),
        Expanded(
          child: recentState
              ? const RecentState(title: "Alhay Pharmacy")
              : const SearchItemlist(),
        )
      ],
    );
  }
}
