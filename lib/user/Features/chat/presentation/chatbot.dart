import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety/auth/data/models/user_strorge.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/core/utils/app_router.dart';
import 'package:dio/dio.dart';
import 'package:taht_bety/core/widgets/custom_cushed_image.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  final String? time;

  const ChatMessage({
    required this.text,
    required this.isUser,
    this.time,
  });
}

String baseUrl = 'https://1242-41-234-34-151.ngrok-free.app/';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final user = UserStorage.getUserData();
  late List<ChatMessage> _messages;
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();

    _messages = [
      const ChatMessage(
        text: 'initializing chat...',
        isUser: false,
        time: '19:00',
      )
    ];

    _initChat();
  }

  Future<void> _initChat() async {
    try {
      final response = await Dio().post(
        '${baseUrl}start_chat',
        data: {
          'user_id': user.userId,
        },
      );

      final botReply = response.data['message'];
      setState(() {
        _messages.add(ChatMessage(
          text: botReply,
          isUser: false,
          time: TimeOfDay.now().format(context),
        ));
        _isTyping = false;
      });
    } catch (e) {
      setState(() {
        _messages.add(ChatMessage(
          text: 'There was an error. Please try again.',
          isUser: false,
          time: TimeOfDay.now().format(context),
        ));
        _isTyping = false;
      });
      _messageController.clear();
    }
  }

  Future<void> _sendMessage() async {
    final userMessage = _messageController.text.trim();
    if (userMessage.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(
        text: userMessage,
        isUser: true,
        time: TimeOfDay.now().format(context),
      ));
      _isTyping = true;
    });

    try {
      String mes = _messageController.text;
      _messageController.clear();
      final response = await Dio().post(
        '${baseUrl}chat',
        data: {
          'message': "$mes answer me in english only",
        },
      );

      final botReply = response.data['response'];

      setState(() {
        _messages.add(ChatMessage(
          text: botReply,
          isUser: false,
          time: TimeOfDay.now().format(context),
        ));
        _isTyping = false;
      });
    } catch (e) {
      setState(() {
        _messages.add(ChatMessage(
          text: 'There was an error. Please try again.',
          isUser: false,
          time: TimeOfDay.now().format(context),
        ));
        _isTyping = false;
      });
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: InkWell(
                onTap: () {
                  context.go(AppRouter.kHomePage);
                },
                child: const Center(
                  child: CircleAvatar(
                    radius: 32,
                    backgroundColor: kWhite,
                    child: CircleAvatar(
                      backgroundColor: kPrimaryColor,
                      radius: 30,
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        reverse:
                            true, // Auto-scroll to bottom when new messages arrive
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                            bottom: 20, // Space for input field
                          ),
                          child: ChatMessages(
                            messages: _messages,
                            userImage: user.photo,
                          ),
                        ),
                      ),
                    ),
                    if (_isTyping) // عرض مؤشر الكتابة أثناء انتظار الرد
                      const Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          'Chatbot is typing...',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            MessageInputField(
              controller: _messageController,
              onSend: _sendMessage,
              isLoading: _isTyping,
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessages extends StatelessWidget {
  final List<ChatMessage> messages;
  final String userImage;
  const ChatMessages(
      {super.key, required this.messages, required this.userImage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: messages
          .map((message) => Column(
                children: [
                  MessageBubble(
                    text: message.text,
                    isUser: message.isUser,
                    showAvatar: true,
                    time: message.time,
                    image: userImage,
                  ),
                  const SizedBox(height: 10),
                ],
              ))
          .toList(),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String text;
  final bool isUser;
  final bool showAvatar;
  final String? time;
  final String image;

  const MessageBubble({
    super.key,
    required this.text,
    required this.isUser,
    this.showAvatar = false,
    this.time,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: isUser ? 25 : 25,
        right: isUser ? 25 : 25,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser && showAvatar)
            const CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(
                  'assets/images/117c96b1a51a7ed8cc29ef8120de09a1.gif'),
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
            CustomCushedImage(image: image, height: 40, width: 40),
        ],
      ),
    );
  }
}

class MessageInputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final bool isLoading;

  const MessageInputField({
    super.key,
    required this.controller,
    required this.onSend,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // This makes the entire input field area white
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white, // White background for the input container
                border: Border.all(color: const Color(0xFF99A8C2)),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        hintText: 'Type here...',
                        hintStyle: TextStyle(
                          color: Color(0xFF99A8C2),
                          fontSize: 16,
                        ),
                        border: InputBorder.none,
                        filled: true,
                        fillColor:
                            Colors.white, // White background for the TextField
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 20),
          InkWell(
            onTap: isLoading ? () {} : onSend,
            child: const CircleAvatar(
              backgroundColor: Color(0xFF3A4D6F),
              child: Icon(
                Icons.send,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
