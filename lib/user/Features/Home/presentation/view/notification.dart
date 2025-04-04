import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety/constants.dart';

import '../../../../../core/utils/app_router.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Map<String, String>> notifications = [
    {
      'title': 'product review request',
      'subtitle': 'Wood Wolf',
      'time': '1h',
      'image': 'assets/images/OIP.jpg',
      'read': 'false',
      'category': 'Today'
    },
    {
      'title': 'Order Shipped',
      'subtitle': 'Alhaya Pharmacy',
      'time': '4h',
      'image': 'assets/images/OIP.jpg',
      'read': 'false',
      'category': 'Today'
    },
    {
      'title': 'Your inquiry has been answered',
      'subtitle': 'Baraka Carpentry',
      'time': '20h',
      'image': 'assets/images/OIP.jpg',
      'read': 'false',
      'category': 'Today'
    },
    {
      'title': 'Order Shipped',
      'subtitle': 'Family Market',
      'time': '1d',
      'image': 'assets/images/OIP.jpg',
      'read': 'false',
      'category': 'Yesterday'
    },
    {
      'title': 'product review request',
      'subtitle': 'Italiano Pizza',
      'time': '1d',
      'image': 'assets/images/OIP.jpg',
      'read': 'false',
      'category': 'Yesterday'
    },
    {
      'title': 'Your inquiry has been answered',
      'subtitle': 'Alhaya Pharmacy',
      'time': '1d',
      'image': 'assets/images/OIP.jpg',
      'read': 'false',
      'category': 'Yesterday'
    },
  ];

  // Mark all notifications in a specific category as read
  void markAllCategoryAsRead(String category) {
    setState(() {
      for (var notification in notifications) {
        if (notification['category'] == category) {
          notification['read'] = 'true';
        }
      }
    });
  }

  // Mark a single notification as read
  void markAsRead(int index) {
    setState(() {
      notifications[index]['read'] = 'true';
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<Map<String, String>>> categorizedNotifications = {};
    for (var notification in notifications) {
      categorizedNotifications
          .putIfAbsent(notification['category']!, () => [])
          .add(notification);
    }

    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: AppBar(
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
             context.go(AppRouter.kHomePage);
            },
          ),
        ),
        title: const Text(
          'Notification',
          style: TextStyle(
              color: Color(0xff15243F),
              fontSize: 20,
              fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        children: categorizedNotifications.entries.map((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(entry.key.toUpperCase(),
                        style: const TextStyle(
                            fontSize: 18, color: Color(0xff8c9197))),
                    TextButton(
                      onPressed: () => markAllCategoryAsRead(entry.key),
                      child: const Text('Mark all as read',
                          style: TextStyle(color: kPrimaryColor)),
                    )
                  ],
                ),
              ),
              ...entry.value.map((notification) {
                return NotificationTile(
                  title: notification['title']!,
                  subtitle: notification['subtitle']!,
                  time: notification['time']!,
                  image: notification['image']!,
                  isRead: notification['read'] == 'true',
                  onTap: () => markAsRead(notifications.indexOf(notification)),
                );
              }).toList(),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final String image;
  final bool isRead;
  final VoidCallback onTap;

  const NotificationTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.image,
    required this.isRead,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(
            color: isRead ? Colors.white : const Color(0xffd0d9ea),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade200, spreadRadius: 1, blurRadius: 5),
            ],
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(image),
            ),
            title: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(subtitle),
            trailing: Text(time, style: const TextStyle(color: Colors.grey)),
          ),
        ),
      ),
    );
  }
}
