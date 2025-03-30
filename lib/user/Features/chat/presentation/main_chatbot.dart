import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';

class MainChatbot extends StatelessWidget {
  const MainChatbot({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    top: 600,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  _buildMainChatBot(context)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: kPrimaryColor,
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 10),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_outlined, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMainChatBot(BuildContext context) {
    const double profilePictureSize = 120.0; // Fixed profile picture size
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -profilePictureSize / 10,
            left: 0,
            right: 0,
            child: Column(
              spacing: 45,
              children: [
                const Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(
                        "assets/images/117c96b1a51a7ed8cc29ef8120de09a1.gif",
                      ),
                      backgroundColor: Colors.white,
                      radius: 70,
                    ),
                  ],
                ),
                const Text(
                  """
Welcome to Your 
     AI Assistant
                      """,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  """
   Using this software ,you can ask 
questions and receive answers using
   artificial intelligence assistant
""",
                  style: TextStyle(
                      wordSpacing: 2,
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 30),
                const Text(
                  "Explore AI ChatBots",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                CircleAvatar(
                  backgroundColor: kPrimaryColor,
                  radius: 30,
                  child: CircleAvatar(
                    backgroundColor: kWhite,
                    radius: 27,
                    child: IconButton(
                        color: kPrimaryColor,
                        onPressed: () {

                          
                        },
                        icon: const Icon(
                          Icons.chat_rounded,
                          size: 35,
                        )),
                  ),
                )
                // CircleAvatar(
                //     backgroundColor: kPrimaryColor,
                //     radius: 40,
                //     child: Image.asset(
                //       'assets/icons/chatbotw.png',
                //       fit: BoxFit.cover,
                //     )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
