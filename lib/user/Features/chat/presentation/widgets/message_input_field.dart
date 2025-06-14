import 'package:flutter/material.dart';
import 'package:taht_bety/constants.dart';

class MessageInputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const MessageInputField({
    super.key,
    required this.controller,
    required this.onSend,
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
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'Type here',
                  hintStyle: TextStyle(
                    color: Color(0xFF99A8C2),
                    fontSize: 16,
                  ),
                  suffixIcon:
                      Icon(Icons.mic_none_outlined, color: kPrimaryColor),
                  border: InputBorder.none,
                ),
                onSubmitted: (_) => onSend(),
              ),
            ),
          ),
          const SizedBox(width: 20),
          InkWell(
            onTap: onSend,
            child: const CircleAvatar(
              backgroundColor: Color(0xFF3A4D6F),
              child: Icon(Icons.send, color: Colors.white, size: 25),
            ),
          ),
        ],
      ),
    );
  }
}
