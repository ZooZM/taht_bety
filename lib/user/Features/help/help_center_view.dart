import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              tabButton('FAQ', 0),
              tabButton('Contact Us', 1),
            ],
          ),
          const Divider(
            color: Colors.grey,
          ),
          Expanded(
            child: _selectedTabIndex == 0 ? faqSection() : contactUsSection(),
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
        faqItem('Can I Track my order’s delivery status?',
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry'),
        const SizedBox(
          height: 16,
        ),
        faqItem('Can I save my favorite items for later?', ''),
        const SizedBox(
          height: 16,
        ),
        faqItem('How do I contact customer support?', ''),
        const SizedBox(
          height: 16,
        ),
        faqItem('How to add Review', ''),
      ],
    );
  }

  Widget faqItem(String question, String answer) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(20)),
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
              if (answer.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    answer,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
            ],
          ),
        ));
  }

  Widget contactUsSection() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        contactItem(
          Icons.headset_mic,
          'Customer Service',
        ),
        const SizedBox(
          height: 16,
        ),
        contactItem(FontAwesomeIcons.whatsapp, 'WhatsApp', '+20 11 1213 1460'),
        const SizedBox(
          height: 16,
        ),
        contactItem(Icons.facebook, 'Facebook'),
        const SizedBox(
          height: 16,
        ),
        contactItem(FontAwesomeIcons.instagram, 'Instagram'),
      ],
    );
  }

  Widget contactItem(IconData icon, String title, [String? subtitle]) {
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
          leading: Icon(
            icon,
            size: 30,
            color: const Color(0xff15243F),
          ),
          title: Text(title),
          trailing: const Icon(Icons.keyboard_arrow_down),
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
    );
  }
}
