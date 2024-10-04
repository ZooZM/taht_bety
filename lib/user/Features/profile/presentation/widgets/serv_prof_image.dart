import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:taht_bety/constants.dart';

class ServProfImage extends StatelessWidget {
  const ServProfImage({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.145,
      width: width * 0.306,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: kBlack,
          width: 2,
        ),
      ),
      child: ClipOval(
        child: CachedNetworkImage(
          // color: kBlack,
          fit: BoxFit.cover,
          imageUrl:
              "https://s3-alpha-sig.figma.com/img/4462/f86c/be9aed939e6541909caa1044e75b1002?Expires=1728864000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Gk-jUQ-UjKv46H5rMDYdeLqKUU~YAfwgKSOM6zlM3dySPjJChqups3qL~QvcBdxS7xUVmzLT-PwavRJ5JyBSCJZaCqpMkzRez59MMtapQUWVTnZsIVhEqxPiJn3BvLgakUQp0bRgzW8VgdpeSm69b2DDIX3gj7LGNcbG7l5~f1jP4kCHsaNywgIMMMxchpjqQyJ0SV9NGykHg4IuYVcUoaEhPpV1tR~hpKBFnbClEgLr8-EK-QGDVfjo26-YBQo6HgRByEuYKxb5yAADAxx5~q78H-h1E3JhOA~3VnQAjpVvkncBEn9FMO02isg3mm4k9NTD~wmwaU5ZpBMeOX1q0w__",
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
