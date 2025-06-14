import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String text;
  final bool isUser;
  final bool showAvatar;
  final String? time;
  final String userImage;
  final String providerImage;

  const MessageBubble({
    super.key,
    required this.text,
    required this.isUser,
    this.showAvatar = false,
    this.time,
    required this.userImage,
    required this.providerImage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser && showAvatar)
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                providerImage, // Replace with providerImage
              ),
            ),
          if (!isUser && showAvatar) const SizedBox(width: 10),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: isUser ? const Color(0xFFCFD9E9) : Colors.transparent,
                border:
                    isUser ? null : Border.all(color: const Color(0xFFCFD9E9)),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: Radius.circular(isUser ? 12 : 0),
                  bottomRight: Radius.circular(isUser ? 0 : 12),
                ),
              ),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF15243F),
                ),
              ),
            ),
          ),
          if (isUser && showAvatar) const SizedBox(width: 10),
          if (isUser && showAvatar)
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                userImage, // Replace with providerImage
              ),
            ),
        ],
      ),
    );
  }
}
