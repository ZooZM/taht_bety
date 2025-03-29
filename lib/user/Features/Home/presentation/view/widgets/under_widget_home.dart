import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taht_bety/core/widgets/custom_circular_progress.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/widgets/home_failure_page.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/widgets/item_list.dart';
import 'package:taht_bety/user/Features/Home/presentation/view_model/providers_cubit/providers_cubit.dart';

class UnderWidgetHome extends StatefulWidget {
  const UnderWidgetHome({super.key});

  @override
  State<UnderWidgetHome> createState() => _UnderWidgetHomeState();
}

class _UnderWidgetHomeState extends State<UnderWidgetHome> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProvidersCubit, ProvidersState>(
      builder: (context, state) {
        if (state is ProvidersLoading) {
          return const Center(
            // child: RippleLoading(
            //   size: 150,
            //   color: ksecondryColor,
            // ),
            child: CustomCircularprogress(size: 50),
          );
        } else if (state is ProvidersSuccess) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              ItemsList(
                providers: state.providers,
              ),
            ],
          );
        } else if (state is ProvidersFailure) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 1.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                HomeFailurePage(
                  failureMssg: state.failureMssg,
                  icon: Icons.error_outline_sharp,
                ),
              ],
            ),
          );
        } else {
          return const HomeFailurePage(
            icon: Icons.error_outline_sharp,
            failureMssg: "Unexpected error occurred.",
          );
        }
      },
    );
  }
}
