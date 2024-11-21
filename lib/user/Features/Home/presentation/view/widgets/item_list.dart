import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety/core/utils/app_router.dart';
import 'package:taht_bety/core/widgets/custom_failure_message.dart';
import 'package:taht_bety/user/Features/Home/data/models/provider_model/provider_model.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/widgets/item_card.dart';
import 'package:taht_bety/user/Features/Home/presentation/view_model/providers_cubit/providers_cubit.dart';

class ItemsList extends StatelessWidget {
  const ItemsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProvidersCubit, ProvidersState>(
      builder: (context, state) {
        if (state is ProvidersSuccess) {
          List<ProviderModel> providers = state.providers;
          return SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: GestureDetector(
                  onTap: () {
                    context.go(AppRouter.kServProfile);
                  },
                  child: ItemCard(
                    provider: providers[index],
                  ),
                ),
              ),
              childCount: providers.length,
            ),
          );
        } else if (state is ProvidersFailure) {
          return SliverToBoxAdapter(
            child: CustomFailureMessage(mess: state.failureMssg),
          );
        } else {
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
