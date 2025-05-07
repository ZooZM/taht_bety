import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety/core/utils/app_router.dart';
import 'package:taht_bety/core/utils/styles.dart';

import '../../../../constants.dart';

class MainChatbot extends StatelessWidget {
  const MainChatbot({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: _buildMainChatBot(context),
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
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildHeader(context),
          const Spacer(
            flex: 1,
          ),
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
          const Spacer(
            flex: 1,
          ),
          const Text(
            "Welcome to Your\nAI Assistant ",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const Spacer(
            flex: 1,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text(
              "Using this software,you can ask  questions and receive answers using artificial intelligence assistant",
              style: Styles.text14Light.copyWith(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(flex: 8),
          SizedBox(
            height: size.height * 0.2,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                // White rounded container
                Container(
                  width: double.infinity,
                  height: size.height * 0.2 * 0.5,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                ),
                Positioned(
                  top: size.height * 0.2 * 0.6 - 90,
                  child: Column(
                    children: [
                      const Text(
                        "Explore AI ChatBots",
                        style: TextStyle(
                          color: kWhite,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {
                          context.push(AppRouter.kChatBot);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(color: kPrimaryColor, width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(0.5), // لون ظل أغمق
                                blurRadius: 10, // كل ما زاد، كل ما بقى أنعم
                                spreadRadius: 2, // يزيد من مدى انتشار الظل
                                offset: const Offset(0, 5), // يتحرك الظل للأسفل
                              ),
                            ],
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(
                                4.0), // padding بسيط لتوسيع المساحة
                            child: CircleAvatar(
                              radius: 35,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.chat_bubble,
                                color: kPrimaryColor,
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
