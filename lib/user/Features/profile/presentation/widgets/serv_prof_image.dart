import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:taht_bety/constants.dart';

class ServProfImage extends StatelessWidget {
  const ServProfImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: LayoutBuilder(
        builder: (context, constraints) {
          double imageSize = constraints.maxWidth;

          return Container(
            height: imageSize,
            width: imageSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: kBlack,
                width: 2,
              ),
            ),
            child: ClipOval(
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl:
                    "https://s3-alpha-sig.figma.com/img/4462/f86c/be9aed939e6541909caa1044e75b1002?Expires=1733097600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=psUPXKq4gZ-JKbqlJJ~e-hLgS1tsL6~xwelR1Mnp1AIWQQFLlEY7ii-GmgKvyDO2iqqc4AYWP6SaBXRODUIzPubWcR9xEReBk4MabfoUf0AI35-r~vfBIxo3D~Z2wQ9J4hleXaj2O7gi3tQZb75FOOqDroe9OGMr5V-lemBXPeMtyuyT8HHxZ3zzmzdnj3bSDFTTpri~-7lfd3CMk5e8OPxpY280oejh5JWEIHPpDab86vFV3T1TAHtBU~2o-3FyEgUofPlCsr1Ua4g~ilBc1aijBTY1s3L-gaHyg7Xh3zsKsJDrXs4hifZzZSJM-I1GaxHvm18~J6jkbgekhNxTqQ__",
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          );
        },
      ),
    );
  }
}
