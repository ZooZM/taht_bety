import 'package:flutter/material.dart';

import 'textformfield.dart';

class ChangePhoneDialog extends StatefulWidget {
  @override
  _ChangePhoneDialogState createState() => _ChangePhoneDialogState();
}

class _ChangePhoneDialogState extends State<ChangePhoneDialog> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _newPhoneController = TextEditingController();
  bool _isVerifying = false;
  bool _isEnteringNewPhone = false;
  final int _timerSeconds = 90;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!_isVerifying) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.close_rounded,
                      color: Colors.black,
                      weight: 2,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Text(
                "Before you change your phone number, verify your current number\n(+201******439)",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff15243f),
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isVerifying = true;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2C3E5A),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  fixedSize: const Size(120, 50),
                ),
                child: const Text("Send code",
                    style: TextStyle(color: Colors.white)),
              ),
            ] else if (!_isEnteringNewPhone) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.close_rounded,
                      color: Colors.black,
                      weight: 2,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Text(
                "Enter code",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff15243f),
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: SizedBox(
                      width: 35,
                      height: 35,
                      child: TextField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            counterText: ""),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      // Handle resend code logic
                    },
                    child: const Text("Send new code",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff15243f),
                            fontWeight: FontWeight.w500)),
                  ),
                  Text(
                    "1:${_timerSeconds ~/ 10}${_timerSeconds % 10}",
                    style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xff15243f),
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isEnteringNewPhone = true;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2C3E5A),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  fixedSize: const Size(120, 50),
                ),
                child:
                    const Text("Verify", style: TextStyle(color: Colors.white)),
              ),
            ] else ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.close_rounded,
                      color: Colors.black,
                      weight: 2,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              CustomTextForm(
                keyboardType: TextInputType.emailAddress,
                validate: (val) {
                  return null;
                },
                labelText: "New Phone Number",
                mycontroller: _newPhoneController,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2C3E5A),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  fixedSize: const Size(120, 50),
                ),
                child:
                    const Text("Change", style: TextStyle(color: Colors.white)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

void showChangePhoneDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => ChangePhoneDialog(),
  );
}
