import 'package:flutter/material.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/utils/styles.dart';
import 'package:taht_bety/user/Features/profile/presentation/widgets/serv_profile_rate.dart';

class ServProfileInfo extends StatelessWidget {
  const ServProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        const SizedBox(height: 4),
        _buildLocationRow(),
      ],
    );
  }

  Widget _buildHeader() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            "Arabian Carpentry",
            style: Styles.subtitle18Bold,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          ),
        ),
        SizedBox(width: 12),
        ServProfileRate(),
      ],
    );
  }

  /// Builds the row containing the location icon and address.
  Widget _buildLocationRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.place_outlined,
          size: 24,
          color: ksecondryColor,
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            "Street 306 - Saqr Quraish District",
            style: Styles.text12Light.copyWith(color: ksecondryColor),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
