import 'package:flutter/material.dart';
import 'package:taht_bety/user/Features/order/presentation/view/widgets/tab_bar_header.dart';

import 'widgets/order_class.dart';
import 'widgets/order_list_view.dart';

class OrderView extends StatefulWidget {
  @override
  _OrderViewState createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  int _selectedIndex = 0;

  final List<String> tabs = ['Active', 'Completed', 'Cancelled'];

  final Map<String, List<Order>> orders = {
    'Active': [
      Order(
          id: "#922529",
          date: "April,06",
          store: "Family Market",
          image: 'images/Frame 2.png'),
      Order(
          id: "#922919",
          date: "March,06",
          store: "Family Market",
          image: 'images/Frame 2.png'),
      Order(
          id: "#922529",
          date: "April,06",
          store: "Family Market",
          image: 'images/Frame 2.png'),
      Order(
          id: "#922919",
          date: "March,06",
          store: "Family Market",
          image: 'images/Frame 2.png'),
    ],
    'Completed': [
      Order(
          id: "#789422",
          date: "September,26",
          store: "Family Market",
          image: 'images/Frame 2.png'),
      Order(
          id: "#145972",
          date: "July,18",
          store: "Family Market",
          image: 'images/Frame 2.png'),
      Order(
          id: "#922529",
          date: "April,06",
          store: "Family Market",
          image: 'images/Frame 2.png'),
      Order(
          id: "#922919",
          date: "March,06",
          store: "Family Market",
          image: 'images/Frame 2.png'),
    ],
    'Cancelled': [
      Order(
          id: "#23543",
          date: "July,13",
          store: "Family Market",
          image: 'images/Frame 2.png'),
      Order(
          id: "#145723",
          date: "July,02",
          store: "Family Market",
          image: 'images/Frame 2.png'),
      Order(
          id: "#922529",
          date: "April,06",
          store: "Family Market",
          image: 'images/Frame 2.png'),
      Order(
          id: "#922919",
          date: "March,06",
          store: "Family Market",
          image: 'images/Frame 2.png'),
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xffFFFFFF),
        title: const Text(
          'My Orders',
          style: TextStyle(
              color: Color(0xff15243F),
              fontSize: 20,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: Container(
          margin: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
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
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
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
            child: OrderListView(
                orders: orders, tabs: tabs, selectedIndex: _selectedIndex),
          ),
        ],
      ),
    );
  }
}
