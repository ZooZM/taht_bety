import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taht_bety/constants.dart';

class SearchBarOfSearchBody extends StatelessWidget {
  const SearchBarOfSearchBody({
    super.key,
    required this.onChange,
  });
  final ValueChanged<String> onChange;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.876,
      height: MediaQuery.of(context).size.height * 0.07,
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: List.filled(
          1,
          const BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset.zero,
          ),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 16,
          ),
          const Icon(
            FontAwesomeIcons.magnifyingGlass,
            size: 24,
            color: kPrimaryColor,
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search",
                border: InputBorder.none,
              ),
              autocorrect: true,
              cursorColor: kPrimaryColor,
              onChanged: onChange,
            ),
          )
        ],
      ),
    );
  }
}
