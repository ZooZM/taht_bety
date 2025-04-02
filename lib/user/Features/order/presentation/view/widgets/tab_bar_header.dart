import 'package:flutter/material.dart';

class TabBarHeader extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final Function(int) onTabSelected;

  TabBarHeader(
      {required this.tabs,
      required this.selectedIndex,
      required this.onTabSelected});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: tabs.map((tab) {
        int index = tabs.indexOf(tab);
        return GestureDetector(
          onTap: () => onTabSelected(index),
          child: Column(
            children: [
              Text(tab,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: selectedIndex == index
                          ? const Color(0xff15243F)
                          : Colors.grey)),
              if (selectedIndex == index)
                Container(height: 3, width: 60, color: const Color(0xff15243F)),
            ],
          ),
        );
      }).toList(),
    );
  }
}
