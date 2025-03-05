import 'dart:async';

import 'package:draggable_float_widget/draggable_float_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/widgets/categories_list.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/widgets/under_widget_home.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/widgets/upper_widget_home.dart';
import 'package:taht_bety/user/Features/Home/presentation/view_model/providers_cubit/providers_cubit.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  late StreamController<OperateEvent> eventStreamController;

  Future<void> _reloadPage(BuildContext context) async {
    await context.read<ProvidersCubit>().fetchProviderList();
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  void initState() {
    _reloadPage(context);
    eventStreamController = StreamController.broadcast();
    Future.delayed(const Duration(seconds: 2), () {
      eventStreamController.add(OperateEvent.OPERATE_HIDE);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _reloadPage(context),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: const IntrinsicHeight(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: UpperWidgetHome(),
                    ),
                    CategoriesList(),
                    Expanded(
                      child: UnderWidgetHome(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
