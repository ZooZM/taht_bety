import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety/auth/data/models/user_strorge.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/user/Features/chat/data/models/chat_message.dart';
import 'package:taht_bety/user/Features/chat/presentation/widgets/chat_messages.dart';
import 'package:taht_bety/user/Features/chat/presentation/widgets/message_input_field.dart';
import 'package:taht_bety/user/Features/profile/data/models/provider_model/provider_model.dart';

class ChatProviderScreenBody extends StatefulWidget {
  const ChatProviderScreenBody({super.key, required this.provider});
  final ProviderModel provider;
  @override
  State<ChatProviderScreenBody> createState() => _ChatProviderScreenBodyState();
}

class _ChatProviderScreenBodyState extends State<ChatProviderScreenBody> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [
    const ChatMessage(text: 'Hello!', isUser: false, time: '19:02'),
    const ChatMessage(text: 'Hi there!', isUser: true),
  ];
  final user = UserStorage.getUserData();

  void _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;
    final String providerId = widget.provider.providerId!;
    final String chatId = '${providerId}_${user.userId}'; // replace dynamically
    const bool isUser = true;

    final messageData = {
      'text': text,
      'isUser': isUser,
      'timestamp': FieldValue.serverTimestamp(),
    };

    // Add message to subcollection
    await FirebaseFirestore.instance
        .collection('Chats')
        .doc(chatId)
        .collection('messages')
        .add(messageData);

    // Update last message in main chat doc
    await FirebaseFirestore.instance.collection('Chats').doc(chatId).set({
      'provider_id': providerId, // dynamic
      'user_id': user.userId, // dynamic
      'userName': user.name,
      'userImage': user.photo,
      'lastMessage': text,
      'lastMessageTime': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        title: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
                widget.provider.photo!), // Replace with actual image URL,
          ),
          title: Text(widget.provider.name!,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, color: kWhite)),
          subtitle: const Text('Online',
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w400, color: kWhite)),
        ),
        leading: Container(
          margin: const EdgeInsets.only(left: 10, top: 20, bottom: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(25),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => context.pop(),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  reverse: true,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: ChatMessages(
                    messages: _messages,
                    providerId: widget.provider.providerId!,
                    userId: user.userId,
                    userImage: user.photo,
                    providerImage: widget.provider.photo!,
                  ),
                ),
              ),
            ),
            MessageInputField(
              controller: _messageController,
              onSend: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
