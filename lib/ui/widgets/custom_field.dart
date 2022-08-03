import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  const CustomField({
    super.key,
    required this.marginX,
    required this.marginY,
    required this.text,
    required this.controller,
    this.type = TextInputType.name,
  });

  final double marginX;
  final double marginY;
  final String text;
  final TextInputType type;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: marginX, vertical: marginY),
      child: TextField(
        keyboardType: type,
        controller: controller,
        decoration: InputDecoration(
          hintText: text,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
