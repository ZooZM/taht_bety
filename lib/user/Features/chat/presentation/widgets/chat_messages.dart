import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taht_bety/user/Features/chat/data/models/chat_message.dart';
import 'package:taht_bety/user/Features/chat/presentation/widgets/message_bubble.dart';

class ChatMessages extends StatelessWidget {
  final List<ChatMessage> messages;
  final String providerId;
  final String userId;
  final String userImage;
  final String providerImage;
  const ChatMessages(
      {super.key,
      required this.messages,
      required this.providerId,
      required this.userId,
      required this.userImage,
      required this.providerImage});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Chats')
          .doc('${providerId}_$userId') // dynamic
          .collection('messages')
          .orderBy('timestamp')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No messages yet"));
        }

        final docs = snapshot.data!.docs;
        return Column(
          children: docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: MessageBubble(
                text: data['text'] ?? '',
                isUser: data['isUser'] ?? false,
                showAvatar: true,
                time: '',
                userImage: userImage,
                providerImage: providerImage,
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
