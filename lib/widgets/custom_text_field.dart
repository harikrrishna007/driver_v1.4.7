import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.phoneTextEditingController,
    required this.placeholder,
    required this.prefixIcon,
  }) : super(key: key);

  final TextEditingController phoneTextEditingController;
  final String placeholder;
  final IconData prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
      child: TextField(
        controller: phoneTextEditingController,
        keyboardType: TextInputType.text,
        onTap: () {},
        style: TextStyle(
          color: Colors.black,
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
          prefixIcon: Icon(
            prefixIcon,
            color: Colors.green,
            size: 18.0,
          ),
          hintText: placeholder,
        ),
      ),
    );
  }
}