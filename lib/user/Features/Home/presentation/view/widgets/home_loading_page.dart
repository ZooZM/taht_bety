import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:taht_bety/user/Features/Home/data/models/provider_list_model/provider_list_model.dart';
import 'package:taht_bety/user/Features/Home/presentation/view/widgets/item_list.dart';

import '../../../data/models/provider_list_model/coordinates.dart';
import '../../../data/models/provider_list_model/location.dart';

List<ProviderListModel> kProvidersData = [
  ProviderListModel(
    name: "Ahmed Hassan",
    photo:
        "https://static.vecteezy.com/system/resources/previews/045/615/806/non_2x/a-labor-construction-worker-isolated-on-transparent-background-png.png",
    userId: "67c7ce8c94a521b32a64d7dd",
    providerId: "67c7cac76cdb162b6f5113f1",
    providerType: "R-Electric",
    locations: [
      Location(
        coordinates: Coordinates(
          type: "Point",
          coordinates: [31.2357, 30.0444],
        ),
        address: "Downtown Cairo, Egypt",
      ),
    ],
    reviewsCount: 2,
    avgRating: 2.5,
    distance: 2.5,
  ),
  ProviderListModel(
    distance: 2.5,
    name: "Ahmed Hassan",
    photo:
        "https://static.vecteezy.com/system/resources/previews/045/615/806/non_2x/a-labor-construction-worker-isolated-on-transparent-background-png.png",
    userId: "67c7ce8c94a521b32a64d7dd",
    providerId: "67c7cac76cdb162b6f5113f1",
    providerType: "R-Electric",
    locations: [
      Location(
        coordinates: Coordinates(
          type: "Point",
          coordinates: [31.2357, 30.0444],
        ),
        address: "Downtown Cairo, Egypt",
      ),
    ],
    reviewsCount: 2,
    avgRating: 2.5,
  ),
  ProviderListModel(
    distance: 2.5,
    name: "Ahmed Hassan",
    photo:
        "https://static.vecteezy.com/system/resources/previews/045/615/806/non_2x/a-labor-construction-worker-isolated-on-transparent-background-png.png",
    userId: "67c7ce8c94a521b32a64d7dd",
    providerId: "67c7cac76cdb162b6f5113f1",
    providerType: "R-Electric",
    locations: [
      Location(
        coordinates: Coordinates(
          type: "Point",
          coordinates: [31.2357, 30.0444],
        ),
        address: "Downtown Cairo, Egypt",
      ),
    ],
    reviewsCount: 2,
    avgRating: 2.5,
  ),
  ProviderListModel(
    distance: 2.5,
    name: "Ahmed Hassan",
    photo:
        "https://static.vecteezy.com/system/resources/previews/045/615/806/non_2x/a-labor-construction-worker-isolated-on-transparent-background-png.png",
    userId: "67c7ce8c94a521b32a64d7dd",
    providerId: "67c7cac76cdb162b6f5113f1",
    providerType: "R-Electric",
    locations: [
      Location(
        coordinates: Coordinates(
          type: "Point",
          coordinates: [31.2357, 30.0444],
        ),
        address: "Downtown Cairo, Egypt",
      ),
    ],
    reviewsCount: 2,
    avgRating: 2.5,
  ),
  ProviderListModel(
    distance: 2.5,
    name: "Ahmed Hassan",
    photo:
        "https://static.vecteezy.com/system/resources/previews/045/615/806/non_2x/a-labor-construction-worker-isolated-on-transparent-background-png.png",
    userId: "67c7ce8c94a521b32a64d7dd",
    providerId: "67c7cac76cdb162b6f5113f1",
    providerType: "R-Electric",
    locations: [
      Location(
        coordinates: Coordinates(
          type: "Point",
          coordinates: [31.2357, 30.0444],
        ),
        address: "Downtown Cairo, Egypt",
      ),
    ],
    reviewsCount: 2,
    avgRating: 2.5,
  ),
];

class HomeLoadingPage extends StatelessWidget {
  const HomeLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          ItemsList(
            providers: kProvidersData,
          ),
        ],
      ),
    );
  }
}
