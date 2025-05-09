import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety/constants.dart';

// 1. First, define the ChatMessage model class
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

// 2. Main Chat Screen ============================================
class ChatProviderScreen extends StatefulWidget {
  const ChatProviderScreen({super.key});

  @override
  State<ChatProviderScreen> createState() => _ChatProviderScreenState();
}

class _ChatProviderScreenState extends State<ChatProviderScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [
    const ChatMessage(
      text:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      isUser: false,
      time: '19:02',
    ),
    const ChatMessage(
      text: 'Lorem Ipsum is simply',
      isUser: false,
    ),
    const ChatMessage(
      text: 'Lorem Ipsum is simply dummy text of the printing ',
      isUser: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        title: const ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage("assets/images/OIP.jpg"),
          ),
          title: Text(
            'Arabian Carpentry',
            style: TextStyle(fontWeight: FontWeight.bold, color: kWhite),
          ),
          subtitle: Text('Online',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: kWhite,
              )),
        ),
        leading: Container(
          margin: const EdgeInsets.only(left: 10, top: 20, bottom: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(25),
          ),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              context.pop();
            },
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            //  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
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
                          child: ChatMessages(messages: _messages),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            MessageInputField(
              controller: _messageController,
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessages extends StatelessWidget {
  final List<ChatMessage> messages;
  const ChatMessages({super.key, required this.messages});

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

  const MessageBubble({
    super.key,
    required this.text,
    required this.isUser,
    this.showAvatar = false,
    this.time,
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
              backgroundImage: AssetImage('assets/images/OIP.jpg'),
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
            const CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/OIP.jpg'),
            ),
        ],
      ),
    );
  }
}

class MessageInputField extends StatelessWidget {
  final TextEditingController controller;

  const MessageInputField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFF99A8C2)),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        // suffixIcon: Icon(Icons.mic_none_outlined,
                        //                color: kPrimaryColor),
                        hintText: 'Type here or speak',
                        hintStyle: const TextStyle(
                          color: Color(0xFF99A8C2),
                          fontSize: 16,
                        ),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            PopupMenuButton(
                              icon: const Icon(Icons.attach_file,
                                  color: kPrimaryColor, size: 28),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  child: const Row(
                                    children: [
                                      Icon(Icons.image, color: kPrimaryColor),
                                      SizedBox(width: 10),
                                      Text('Image'),
                                    ],
                                  ),
                                  onTap: () {
                                    // Handle image attachment
                                  },
                                ),
                                PopupMenuItem(
                                  child: const Row(
                                    children: [
                                      Icon(Icons.insert_drive_file,
                                          color: kPrimaryColor),
                                      SizedBox(width: 10),
                                      Text('Document'),
                                    ],
                                  ),
                                  onTap: () {
                                    // Handle document attachment
                                  },
                                ),
                                PopupMenuItem(
                                  child: const Row(
                                    children: [
                                      Icon(Icons.location_on,
                                          color: kPrimaryColor),
                                      SizedBox(width: 10),
                                      Text('Location'),
                                    ],
                                  ),
                                  onTap: () {
                                    // Handle location attachment
                                  },
                                ),
                              ],
                              offset: const Offset(0, -150),
                            ),
                            const Icon(Icons.mic_none_outlined,
                                color: kPrimaryColor),
                            const SizedBox(width: 10),
                          ],
                        ),
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 20),
          InkWell(
            onTap: () {},
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
