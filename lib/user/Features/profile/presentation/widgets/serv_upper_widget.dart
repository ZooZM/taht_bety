import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:taht_bety/user/Features/profile/presentation/widgets/serv_prof_image.dart';
import 'package:taht_bety/user/Features/profile/presentation/widgets/serv_profile_appbar.dart';
import 'package:taht_bety/user/Features/profile/presentation/widgets/serv_profile_info.dart';

class ServUpperWidget extends StatelessWidget {
  const ServUpperWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height * 0.335,
      child: Stack(
        children: [
          SizedBox(
            width: width,
            height: height * 0.24,
            child: CachedNetworkImage(
              // color: kBlack,
              fit: BoxFit.cover,
              imageUrl:
                  "https://s3-alpha-sig.figma.com/img/b741/297c/49ff74de02ee0013dd84741b92dde045?Expires=1728864000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=ebIFy7~95VM93FJXb6qmnjLGSmZr8Ynx3aDH-XWDn-yuz1aTKz1KLVOWair84xxGJXvMD51WlloPjYO153MU4rxoxP4QOi~A-TIAzWNgW~j8f1tFF7cnUUBQ2EsNHy~7D6EuCN4XpirODLkl6TcqUcVpNqDCHVdzYQGudCpOAfYKaxTK8eybI-CLHvrBVK13vdetpntORThaDbqCAiqYNto3iVNyB6~0Sc2JymjFq83nse5S4pbEb9Q5rjGmoFRN~WaEafOviSiI9fmbgkMeKJhq7lndsdX6I0g4h6oWaoCh57iRh3XeVxM4M4iOeOanRwIaDYU3QRFhqMCOZbLx0w__",
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            child: ServProfileAppBar(),
          ),
          Positioned(
            bottom: 0,
            left: 12,
            child: ServProfImage(height: height, width: width),
          ),
          Positioned(
            bottom: height * 0.007,
            right: 8,
            left: width * 0.37,
            child: const ServProfileInfo(),
          )
        ],
      ),
    );
  }
}
