import 'package:flutter/material.dart';
import 'package:taht_bety/user/Features/Home/widgets/categories_card.dart';

List categoriesName = [
  "All",
  "Restaurant",
  "SuperMarket",
  "House Work",
  "Repair",
  "Clinc",
];
List isCheck = [
  true,
  false,
  false,
  false,
  false,
  false,
];

class CategoriesList extends StatefulWidget {
  const CategoriesList({
    super.key,
  });

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.054,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoriesName.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(left: 16),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                for (int i = 0; i < isCheck.length; i++) {
                  isCheck[i] = (i == index);
                }
              });
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: CategoriesCard(
              title: categoriesName[index],
              isCheck: isCheck[index],
            ),
          ),
        ),
      ),
    );
  }
}
