import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taht_bety/auth/data/models/curuser.dart';
import 'package:taht_bety/auth/data/models/user_strorge.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/user/Features/profile/data/models/provider_model/post.dart';
import 'package:taht_bety/user/Features/service/presentation/view/widgets/appointment_booking_widget.dart';
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
  }

  Future<void> _order(DateTime date, String time) async {
    setState(() => isLoading = true);
    Navigator.pop(context); // إغلاق البوتوم شيت
    CurUser user = UserStorage.getUserData();

    try {
      final response = await Dio().post(
        '${kBaseUrl}orders/create-order',
        data: {
          'providerID': widget.post.providerId,
          'postID': widget.post.id,
          'price': widget.post.price,
          'description': 'Order from Taht Bety',
          'date': DateFormat('yyyy-MM-dd').format(date),
          'time': time,
        },
        options: Options(
          headers: {'Authorization': 'Bearer ${user.token}'},
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.pop(context); // إغلاق البوتوم شيت
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("تم حجز الموعد بنجاح"),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Error: ${e.response!.data['message']}"),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("DioException: ${e.message}"),
            ),
          );
        }
      } else if (e is FormatException) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("FormatException: Invalid date format"),
          ),
        );
      }
    } finally {
      setState(() => isLoading = false);
    }
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
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  useSafeArea: true,
                  builder: (context) {
                    return ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.9,
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: AppointmentBookingWidget(
                            isLoading: isLoading,
                            onBookAppointment: _order,
                          ),
                        ),
                      ),
                    );
                  },
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
