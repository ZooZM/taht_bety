import 'package:flutter/material.dart';
import 'package:taht_bety/core/widgets/custom_cushed_image.dart';

class ServProfImage extends StatelessWidget {
  const ServProfImage({
    super.key,
    required this.image,
  });
  final String image;
  @override
  Widget build(BuildContext context) {
    return CustomCushedImage(
      image: image,
      height: 0.125,
      width: 0.27,
    );
  }
}
