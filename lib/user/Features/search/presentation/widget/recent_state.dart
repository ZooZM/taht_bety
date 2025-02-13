import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taht_bety/core/utils/styles.dart';
import 'package:taht_bety/user/Features/search/data/hive_models/recenet_search_model_storge.dart';
import 'package:taht_bety/user/Features/search/data/hive_models/recent_search_model.dart';

class RecentState extends StatefulWidget {
  const RecentState({
    super.key,
    required this.searchModelList,
  });
  final List<RecentSearchModel> searchModelList;

  @override
  State<RecentState> createState() => _RecentStateState();
}

class _RecentStateState extends State<RecentState> {
  void _deleteSearchItem(int id, int index) async {
    await RecentSearchModelStorage.deleteSearch(id);
    setState(() {
      widget.searchModelList.removeAt(index);
    });
  }

  void _clearAllSearches() async {
    await RecentSearchModelStorage.clearAllSearches();
    setState(() {
      widget.searchModelList.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Recent",
                style: Styles.subtitle16Bold,
              ),
              GestureDetector(
                child: const Text(
                  "Clear All",
                  style: Styles.text16SemiBold,
                ),
                onTap: () {
                  _clearAllSearches();
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.searchModelList[index].name,
                    style: Styles.text14Medium,
                  ),
                  GestureDetector(
                    child: const Icon(
                      FontAwesomeIcons.circleXmark,
                      size: 20,
                    ),
                    onTap: () {
                      _deleteSearchItem(
                          widget.searchModelList[index].id, index);
                    },
                  )
                ],
              ),
            ),
            itemCount: widget.searchModelList.length,
          ),
        ),
      ],
    );
  }
}
