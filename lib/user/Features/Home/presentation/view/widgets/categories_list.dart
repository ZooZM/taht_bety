import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taht_bety/data.dart';
import 'package:taht_bety/user/Features/Home/data/models/category_Model.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/widgets/categories_card.dart';
import 'package:taht_bety/user/Features/Home/presentation/view_model/providers_cubit/providers_cubit.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({
    super.key,
  });
  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  Future<void> _filterProviders(BuildContext context, String categoty) async {
    await context.read<ProvidersCubit>().filterProvidersByCategory(categoty);
  }

  final List<CategoryModel> categories = Data.categores;

  @override
  Widget build(BuildContext context) {
    categories.sort((a, b) => a.name.compareTo(b.name));

    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(left: 16),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                for (int i = 0; i < categories.length; i++) {
                  categories[i].hasCliced = (i == index);
                }
                _filterProviders(context, categories[index].name);
              });
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: CategoriesCard(
              title: categories[index].name.split('-')[1],
              isCheck: categories[index].hasCliced,
              icon: categories[index].icon,
            ),
          ),
        ),
      ),
    );
  }
}
