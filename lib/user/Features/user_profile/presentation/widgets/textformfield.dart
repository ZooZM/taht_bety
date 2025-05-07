import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String? hinttext;
  final String labelText;
  final TextEditingController? mycontroller;
  final String? Function(String?)? validate;
  final TextInputType? keyboardType;
  final Widget? suffix;
  bool isPassword;
  CustomTextForm(
      {super.key,
      this.hinttext,
      required this.labelText,
      this.mycontroller,
      this.validate,
      this.keyboardType,
      this.suffix,
      this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: TextFormField(
        obscuringCharacter: '*',
        obscureText: isPassword,
        keyboardType: keyboardType,
        validator: validate,
        cursorColor: Colors.black,
        style: const TextStyle(
            fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
        controller: mycontroller,
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide:
                    const BorderSide(width: 2.0, color: Color(0xFF99A8C2))),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            floatingLabelStyle: const TextStyle(
              color: Color(0xFF99A8C2),
              fontSize: 18,
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide:
                    const BorderSide(width: 2.0, color: Color(0xFF99A8C2))),
            label: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(labelText)),
            hintText: hinttext,
            suffixIcon: suffix,
            labelStyle: TextStyle(
                fontSize: 18,
                color: Theme.of(context).textTheme.labelLarge!.color),
            hintStyle: const TextStyle(fontSize: 14)),
      ),
    );
  }
}
