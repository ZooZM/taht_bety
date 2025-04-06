import 'package:flutter/material.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/user/Features/profile/data/models/provider_model/post.dart';
import 'package:taht_bety/user/Features/service/presentation/view/widgets/book_service.dart';
import 'package:taht_bety/user/Features/service/presentation/view/widgets/service_images_widget.dart';
import 'package:taht_bety/user/Features/service/presentation/view/widgets/service_info_widget.dart';

class ServiceDetailsBody extends StatefulWidget {
  const ServiceDetailsBody({super.key, required this.post});
  final Post post;

  @override
  State<ServiceDetailsBody> createState() => _ServiceDetailsBodyState();
}

class _ServiceDetailsBodyState extends State<ServiceDetailsBody> {
  @override
  void initState() {
    super.initState();
    print('Post : ${widget.post.toString()}');
  }

  int count = 1;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ServiceImagesWidget(
                  images: (widget.post.images != null &&
                          widget.post.images!.isNotEmpty)
                      ? widget.post.images!
                      : <String>[],
                ),
                const SizedBox(height: 12),
                ServiceInfoWidget(
                  price: widget.post.price.toString(),
                  description: widget.post.content!,
                  title: widget.post.title!,
                ),
                const SizedBox(height: 50),
                //  Reviews(reviews: widget.post,)
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 5,
          right: 0,
          left: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BookService(
              price: (widget.post.price! * count).toString(),
              onTap: () async {
                setState(() {
                  isLoading = true;
                });

                setState(() {
                  isLoading = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Added to basket')),
                );
              },
              isLoading: isLoading,
            ),
          ),
        ),
        Positioned(
          top: 5,
          left: 16,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: kWhite,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 1,
                )
              ],
            ),
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 30,
                )),
          ),
        ),
      ],
    );
  }
}
