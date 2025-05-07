import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xffFFFFFF),
        title: const Text(
          'Help Center',
          style: TextStyle(
              color: Color(0xff15243F),
              fontSize: 20,
              fontWeight: FontWeight.w600),
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
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              tabButton('FAQ', 0),
              tabButton('Contact Us', 1),
            ],
          ),
          const Divider(color: Colors.grey),
          Expanded(
            child: _selectedTabIndex == 0
                ? faqSection()
                : contactUsSection(context),
          ),
        ],
      ),
    );
  }

  Widget tabButton(String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: _selectedTabIndex == index ? Colors.black : Colors.grey,
            ),
          ),
          if (_selectedTabIndex == index)
            Container(
              margin: const EdgeInsets.only(top: 3),
              height: 2,
              width: 80,
              color: Colors.black,
            ),
        ],
      ),
    );
  }

  Widget faqSection() {
    return ListView(
      padding: const EdgeInsets.only(top: 20, left: 8, right: 8),
      children: [
        faqItem(
          'Can I Track my order’s delivery status?',
          'You can track your order by going to the "My Orders" section and clicking on "Track".',
        ),
        const SizedBox(height: 16),
        faqItem(
          'Can I save my favorite items for later?',
          'Yes, simply tap the heart icon to add items to your wishlist.',
        ),
        const SizedBox(height: 16),
        faqItem(
          'How do I contact customer support?',
          'You can reach out through phone, WhatsApp, or by submitting a support ticket.',
        ),
        const SizedBox(height: 16),
        faqItem(
          'How to add Review',
          'Go to the product or Provider page you purchased, then click on "Write a Review".',
        ),
      ],
    );
  }

  Widget faqItem(String question, String answer) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          title: Text(
            question,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                answer,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget contactUsSection(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        contactItem(
          Icons.headset_mic,
          'Customer Service',
          '+20 15 0820 0037',
          () => _launchPhone('+201508200037'),
        ),
        const SizedBox(height: 16),
        contactItem(
          FontAwesomeIcons.whatsapp,
          'WhatsApp',
          '+20 15 0820 0037',
          () => _launchWhatsApp('+201508200037'),
        ),
        const SizedBox(height: 16),
        contactItem(
          Icons.email,
          'Email',
          'tahtbety@gmail.com',
          () => _launchEmail('tahtbety@gmail.com'),
        ),
      ],
    );
  }

  Widget contactItem(IconData icon, String title,
      [String? subtitle, VoidCallback? onTap]) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
          ),
          child: ExpansionTile(
            leading: Icon(
              icon,
              size: 30,
              color: const Color(0xff15243F),
            ),
            title: Text(title),
            children: [
              if (subtitle != null)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      subtitle,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchEmail(String emailAddress) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: emailAddress,
      query: Uri.encodeFull('subject=Support Request&body=Hello,'),
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      debugPrint('Could not launch email client');
    }
  }

  Future<void> _launchPhone(String phoneNumber) async {
    final Uri telUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(telUri)) {
      await launchUrl(telUri);
    } else {
      debugPrint('Could not launch phone dialer');
    }
  }

  Future<void> _launchWhatsApp(String phoneNumber) async {
    final Uri whatsappUri =
        Uri.parse("https://wa.me/${phoneNumber.replaceAll('+', '')}");
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch WhatsApp');
    }
  }
}
