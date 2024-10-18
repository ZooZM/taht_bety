import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/utils/styles.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: 350,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            width: 222,
            height: 114,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Badrooms",
                  style: Styles.subtitle16Bold,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: 212,
                      child: Text(
                        "consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna ",
                        style: Styles.text14Medium,
                        softWrap: true,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text(
                      "20000 - 80000",
                      style: Styles.text14Medium,
                    ),
                    Text(
                      " EGP",
                      style: Styles.text16SemiBold,
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Stack(
            children: [
              SizedBox(
                height: 120,
                width: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    // color: kBlack,
                    fit: BoxFit.cover,
                    imageUrl:
                        "https://s3-alpha-sig.figma.com/img/814c/902a/8d92023fe7ac38baa31f6faae9b6f752?Expires=1730073600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=CYJcnvEkiIF8xknf0NAJjBOQ~mC0cizutz57juIBSsvSOBviTeWiqHeOnHw7p9X8j3yPdW1lBPxKomf53M2js5WdZv15HuLSSLzjwMNJgq~gcjHEo1n4z2x6PLWfGaZTDLvI5Vu7Of6-79TJyEAIsks0yQrLMMYrp~j4Vg2oNlJHKcTglt5-Wt6BtNccpsGTL2h5Z7y~MoiLAeZQ0luvNkNgwZGNOnqvzogd8J7ncw6Gyar0u~ODz4z7Zr8E-1RKxvswSLrID4Pmk0oWAKwrTtocgxwNVQm3PMDTM813AfPYJDtA1eLkE2MUNUA4NtifOfZBA65SvzgDJploHrpX0g__",
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.black26,
                ),
                child: Center(
                  child: Text(
                    "+20",
                    style: Styles.subtitle18Bold.copyWith(color: kWhite),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
