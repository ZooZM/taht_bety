import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:taht_bety/user/Features/profile/presentation/widgets/serv_prof_image.dart';
import 'package:taht_bety/user/Features/profile/presentation/widgets/serv_profile_info.dart';

class ServUpperWidget extends StatelessWidget {
  const ServUpperWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width,
      height: height * 0.36,
      child: Stack(
        children: [
          _buildBackgroundImage(width, height),
          _buildProfileImage(),
          _buildTextBelowBackground(width, height),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage(double width, double height) {
    return SizedBox(
      width: width,
      height: height * 0.24,
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl:
            "https://s3-alpha-sig.figma.com/img/b741/297c/49ff74de02ee0013dd84741b92dde045?Expires=1733097600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=gF-JWSJKcIpQRoGjJbDe4ZcoQ0H-lQ59Spxauzy4-FRO0eDQb13HOqDZ-0VtWjnX-rWFWmoK9kXNsxS4a27bizmGvuTpCarspyyrMoUDsGk7DSKNw0r96HYwYoG2Os~NadHPiQEDzAYTmFHkiT1J2ntN2Nakd6AT1WNmtsRwIoA1IlNKzyl5rD15FZkUm-615bwue9ldCu~dRdTlRspXRL3pigOA2wrFgT0DSCOWX3pbteOxSKuQPMnOGZLpx4ZRB~cZY5kLb6ciNGH9WAQ2i2uFAr6qSXBrNtTD7RzW3WUNecF1Pdv0yPwo5S5PmGDjhjOrjB3jXSyBzJ3e8j8mIQ__",
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }

  Widget _buildProfileImage() {
    return const Positioned(
      bottom: 5,
      left: 12,
      child: ServProfImage(),
    );
  }

  Widget _buildTextBelowBackground(double width, double height) {
    return Positioned(
      top: height * 0.235,
      left: 120,
      right: 12,
      child: const ServProfileInfo(),
    );
  }
}
