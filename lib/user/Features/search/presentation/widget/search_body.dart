import 'package:flutter/material.dart';
import 'package:taht_bety/data.dart';
import 'package:taht_bety/user/Features/search/data/hive_models/recenet_search_model_storge.dart';
import 'package:taht_bety/user/Features/search/data/hive_models/recent_search_model.dart';
import 'package:taht_bety/user/Features/Home/data/models/provider_model/provider_model.dart';
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
  List<ProviderModel> providers = [];
  List<RecentSearchModel> recentSearchList = [];
  void _onSearchChanged(String value) {
    setState(() {
      if (value.isEmpty) {
        recentSearchList = RecentSearchModelStorage.getAllSearches();
        recentState = true;
      } else {
        recentState = false;
        providers = Data.providers
            .where((e) => e.name!.toLowerCase().contains(value.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    try {
      recentSearchList = RecentSearchModelStorage.getAllSearches();
      if (recentSearchList.isNotEmpty) {
        print(recentSearchList[0]);
      }
    } catch (e) {
      print('Error while getting recent searches: $e');
    }
  }

  void _onSearchSudmit(String value) async {
    try {
      await RecentSearchModelStorage.addSearch(name: value);
    } catch (e) {
      print('Error while saving search: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 32, left: 16, right: 16, bottom: 12),
          child: SearchBarOfSearchBody(
            onChange: _onSearchChanged,
            onSubmit: _onSearchSudmit,
          ),
        ),
        Expanded(
          child: recentState
              ? RecentState(
                  searchModelList: recentSearchList,
                )
              : SearchItemlist(
                  providers: providers,
                ),
        ),
      ],
    );
  }
}
