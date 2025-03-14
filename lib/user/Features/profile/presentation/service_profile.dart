import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety/user/Features/profile/presentation/view_model/cubit/fetch_provider_cubit.dart';
import 'package:taht_bety/user/Features/profile/presentation/widgets/service_profile_body.dart';

class ServiceProfile extends StatefulWidget {
  const ServiceProfile({super.key});

  @override
  State<ServiceProfile> createState() => _ServiceProfileState();
}

class _ServiceProfileState extends State<ServiceProfile> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final providerId = GoRouterState.of(context).extra as String?;
    if (providerId != null) {
      reloadPage(context, providerId);
    }
  }

  Future<void> reloadPage(BuildContext context, String providerId) async {
    await context.read<FetchProviderCubit>().fetchProvider(providerId);
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<FetchProviderCubit, FetchProviderState>(
          builder: (context, state) {
            if (state is FetchProviderLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is FetchProviderFailure) {
              print(state.failureMssg);
              return Center(
                child: Text(state.failureMssg),
              );
            } else if (state is FetchProviderSuccess) {
              return ServiceProfileBody(
                provider: state.provider,
              );
            } else {
              return const Center(
                child: Text('Error'),
              );
            }
          },
        ),
      ),
    );
  }
}
