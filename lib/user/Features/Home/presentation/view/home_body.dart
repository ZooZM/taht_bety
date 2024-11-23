import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taht_bety/core/widgets/custom_failure_message.dart';
import 'package:taht_bety/core/widgets/customcircularprogress.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/widgets/categories_list.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/widgets/item_list.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/widgets/upper_widget_home.dart';
import 'package:taht_bety/user/Features/Home/presentation/view_model/providers_cubit/providers_cubit.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  Future<void> _reloadPage(BuildContext context) async {
    context.read<ProvidersCubit>().fetchProviderList();
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _reloadPage(context),
      child: BlocBuilder<ProvidersCubit, ProvidersState>(
        builder: (context, state) {
          if (state is ProvidersLoading) {
            return const Center(
              child: CustomCircularprogress(
                size: 50,
              ),
            );
          } else if (state is ProvidersSuccess) {
            return const CustomScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              slivers: [
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
          } else if (state is ProvidersFailure) {
            return Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: UpperWidgetHome(),
                ),
                CustomFailureMessage(
                  mess: state.failureMssg,
                ),
              ],
            );
          } else {
            return const Center(
              child: CustomFailureMessage(
                mess: "Unexpected error occurred.",
              ),
            );
          }
        },
      ),
    );
  }
}
