import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:taht_bety/auth/data/models/user_strorge.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/utils/api_service.dart';
import 'package:taht_bety/core/utils/styles.dart';
import 'package:taht_bety/user/Features/profile/data/models/provider_model/review_post.dart';
import 'package:taht_bety/user/Features/service/presentation/view/widgets/review_post_widget.dart';

class ReviewPostSection extends StatefulWidget {
  final String postId;
  final List<ReviewPost> reviews;
  final String providerId;

  const ReviewPostSection({
    super.key,
    required this.postId,
    required this.reviews,
    required this.providerId,
  });

  @override
  State<ReviewPostSection> createState() => _ReviewPostSectionState();
}

class _ReviewPostSectionState extends State<ReviewPostSection> {
  final TextEditingController _reviewController = TextEditingController();
  int _rating = 0;
  bool reviewLoading = false;
  bool isReviewed = false;
  int reviewedIndex = -1;

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    checkReview();
    super.initState();
  }

  void checkReview() {
    for (var element in widget.reviews) {
      if (element.user!.id == UserStorage.getUserData().userId) {
        setState(() {
          isReviewed = true;
          reviewedIndex = widget.reviews.indexOf(element);
        });
      }
    }
  }

  Future<void> _updateReview() async {
    final user = UserStorage.getUserData();
    final reviewText = _reviewController.text;
    try {
      final dio = Dio();
      final response = await ApiService(dio).put(
        endPoint: 'reviews/${widget.reviews[reviewedIndex].id}',
        data: {
          'review': reviewText,
          'rating': _rating,
        },
        token: user.token,
      );

      if (response['success']) {
        _reviewController.clear();
        setState(() {
          widget.reviews[reviewedIndex] = ReviewPost(
            user: ReviewUser(
              name: user.name,
              photo: user.photo,
              id: user.userId,
            ),
            review: reviewText,
            rating: _rating,
            createdAt: DateTime.now(),
            id: widget.reviews[reviewedIndex].id,
            post: widget.postId,
            updatedAt: DateTime.now(),
          );
          _rating = 0;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please give a Rating and Review"),
            duration: Duration(seconds: 5),
          ),
        );
      }
    } on DioException catch (e) {
      String errorMessage = 'An error occurred during review submission';
      if (e.response != null && e.response!.data is Map<String, dynamic>) {
        errorMessage = e.response!.data['message'] ?? errorMessage;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          duration: const Duration(seconds: 10),
        ),
      );
    }
  }

  Future<void> _submitReview() async {
    setState(() {
      reviewLoading = true;
    });
    final user = UserStorage.getUserData();
    final reviewText = _reviewController.text;

    if (reviewText.isNotEmpty && _rating > 0) {
      try {
        if (isReviewed) {
          await _updateReview();
          setState(() {
            reviewLoading = false;
          });
          return;
        }
        final response = await Dio().post(
          '${kBaseUrl}reviews',
          data: {
            'review': reviewText,
            'rating': _rating,
            'post': widget.postId,
            'provider': widget.providerId,
          },
          options: Options(
            headers: {'Authorization': 'Bearer ${user.token}'},
          ),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          final review = ReviewPost(
            user: ReviewUser(
              name: user.name,
              photo: user.photo,
              id: user.userId,
            ),
            review: reviewText,
            rating: _rating,
            createdAt: DateTime.now(),
            id: response.data['data']['_id'],
            post: widget.postId,
            updatedAt: DateTime.now(),
          );
          _reviewController.clear();
          setState(() {
            _rating = 0;
            widget.reviews.add(review);
            isReviewed = true;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Please give a Rating and Review"),
              duration: Duration(seconds: 5),
            ),
          );
        }
      } on DioException catch (e) {
        String errorMessage = 'An error occurred during review submission';
        if (e.response != null && e.response!.data is Map<String, dynamic>) {
          errorMessage = e.response!.data['message'] ?? errorMessage;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
    setState(() {
      reviewLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Write a Review",
            style: Styles.subtitle16Bold,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _reviewController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: "Write your review here...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: List.generate(
              5,
              (index) => IconButton(
                icon: Icon(
                  index < _rating ? Icons.star : Icons.star_border_outlined,
                  color: ksecondryColor,
                ),
                onPressed: () {
                  setState(() {
                    _rating = index + 1;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: reviewLoading
                  ? ksecondryColor.withOpacity(0.2)
                  : ksecondryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: reviewLoading ? null : _submitReview,
            child: const Text(
              "Submit Review",
              style: TextStyle(color: kWhite),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Text(
              "Rating & Reviews",
              style: Styles.subtitle16Bold,
            ),
          ),
          ListView.builder(
            itemCount: widget.reviews.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                child: ReviewPostWidget(
                  review: widget.reviews[index],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
