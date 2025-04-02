import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety/core/utils/app_router.dart';
import 'package:taht_bety/user/Features/order/presentation/cubit/order_cubit.dart';
import 'package:taht_bety/user/Features/order/presentation/cubit/order_state.dart';
import 'package:taht_bety/user/Features/order/presentation/view/widgets/cart_icon.dart';
import 'package:taht_bety/user/Features/order/presentation/view/widgets/tab_bar_header.dart';
import 'package:taht_bety/user/Features/product/data/basket_model.dart';
import 'package:taht_bety/user/Features/product/data/basket_storage.dart';
import 'widgets/order_list_view.dart';

class OrderView extends StatefulWidget {
  @override
  _OrderViewState createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  int _selectedIndex = 0;

  final List<String> tabs = ["Pending", "Accepted", "Completed", "Cancelled"];
  @override
  void initState() {
    context.read<OrderCubit>().fetchOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: OrderAppBar(),
            ),
            const SizedBox(
              height: 15,
            ),
            TabBarHeader(
              tabs: tabs,
              selectedIndex: _selectedIndex,
              onTabSelected: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
            const Divider(
              color: Colors.grey,
            ),
            Expanded(
              child: BlocBuilder<OrderCubit, OrderState>(
                builder: (context, state) {
                  if (state is OrderLoaded) {
                    return OrderListView(
                      orders: {
                        'Pending': state.orders
                            .where((order) => order.status == 'pending')
                            .toList(),
                        'Accepted': state.orders
                            .where((order) => order.status == 'accepted')
                            .toList(),
                        'Completed': state.orders
                            .where((order) => order.status == 'completed')
                            .toList(),
                        'Cancelled': state.orders
                            .where((order) => order.status == 'canceled')
                            .toList(),
                      },
                      tabs: tabs,
                      selectedIndex: _selectedIndex,
                    );
                  } else if (state is OrderLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is OrderError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return const Center(
                      child: Text('Something went wrong'),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderAppBar extends StatefulWidget {
  const OrderAppBar({
    super.key,
  });

  @override
  State<OrderAppBar> createState() => _OrderAppBarState();
}

class _OrderAppBarState extends State<OrderAppBar> {
  List<BasketModel> baskets = [];
  @override
  void initState() {
    _fetchBasket();
    super.initState();
  }

  void _fetchBasket() {
    baskets = BasketStorage.getAllBasketItems();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(25),
          ),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        const Text(
          'My Orders',
          style: TextStyle(
              color: Color(0xff15243F),
              fontSize: 20,
              fontWeight: FontWeight.w600),
        ),
        GestureDetector(
          onTap: () {
            context.push(AppRouter.kGeneralBasket, extra: baskets);
          },
          child: CartIcon(
            cartCount: baskets.length,
          ),
        )
      ],
    );
  }
}
