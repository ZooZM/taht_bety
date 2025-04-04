import 'package:flutter/material.dart';

class NotificationSettingsScreen extends StatelessWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xffFFFFFF),
        title: const Text(
          'Notification Settings',
          style: TextStyle(
              color: Color(0xff15243F),
              fontSize: 20,
              fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        leading: Container(
          margin: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
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
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 60),
          _buildListTile(
              context: context,
              title: "Orders",
              value: "Get alerts when notification comes in",
              onValue: true),
          _buildListTile(
              context: context,
              title: "Chat",
              value: "Receive Chat notification",
              onValue: true),
          _buildListTile(
              context: context,
              title: "Push Notifications",
              value: "Receive weekly push notification",
              onValue: false),
        ],
      ),
    ));
  }
}

Widget _buildListTile(
    {required BuildContext context,
    required String title,
    required String value,
    required bool onValue}) {
  return Column(
    children: [
      ListTile(
          contentPadding: const EdgeInsets.only(right: 20, left: 5),
          title: Text(title,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff15243f))),
          subtitle: Text(value,
              style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF3a4d6e),
                  fontWeight: FontWeight.w500)),
          trailing: Switch(
            trackOutlineColor: onValue
                ? const WidgetStatePropertyAll(Color(0xff3a4d6e))
                : const WidgetStatePropertyAll(Color(0xffcfd9e9)),
            activeTrackColor: const Color(0xff3a4d6e),
            value: onValue,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: const Color(0xffcfd9e9),
            activeColor: Colors.white,
            thumbColor: const WidgetStatePropertyAll(Colors.white),
            // This is called when the user toggles the switch.
            onChanged: (bool value) {
              // Handle the switch value change
              // You can use setState or any state management solution to update the UI
            },
          )),
    ],
  );
}
