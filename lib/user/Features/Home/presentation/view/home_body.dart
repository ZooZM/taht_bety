import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taht_bety/core/widgets/customcircularprogress.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/widgets/categories_list.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/widgets/home_failure_page.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/widgets/item_list.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/widgets/upper_widget_home.dart';
import 'package:taht_bety/user/Features/Home/presentation/view_model/cubit/fetch_location_cubit.dart';
import 'package:taht_bety/user/Features/Home/presentation/view_model/providers_cubit/providers_cubit.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  Future<void> _reloadPage(BuildContext context) async {
    await context.read<FetchLocationCubit>().fetchLocation();
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _reloadPage(context),
      child: BlocBuilder<FetchLocationCubit, FetchLocationState>(
        builder: (context, locationState) {
          if (locationState is FetchLocationLoading) {
            return const Center(
              child: CustomCircularprogress(size: 50),
            );
          } else if (locationState is FetchLocationFailure) {
            return HomeFailurePage(
              failureMssg: "${locationState.failureMssg},please try again.",
              icon: Icons.location_off_outlined,
            );
          } else if (locationState is FetchLocationSuccess) {
            return BlocBuilder<ProvidersCubit, ProvidersState>(
              builder: (context, state) {
                if (state is ProvidersLoading) {
                  return const Center(
                    child: CustomCircularprogress(size: 50),
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
                      SliverToBoxAdapter(child: CategoriesList()),
                      SliverToBoxAdapter(child: SizedBox(height: 16)),
                      ItemsList(),
                    ],
                  );
                } else if (state is ProvidersFailure) {
                  return HomeFailurePage(
                    failureMssg: state.failureMssg,
                    icon: Icons.error_outline_sharp,
                  );
                } else {
                  return const HomeFailurePage(
                    icon: Icons.error_outline_sharp,
                    failureMssg: "Unexpected error occurred.",
                  );
                }
              },
            );
          } else {
            return const HomeFailurePage(
              icon: Icons.location_off_outlined,
              failureMssg:
                  "Unexpected error occurred while fetching location, please try again.",
            );
          }
        },
      ),
    );
  }
}
