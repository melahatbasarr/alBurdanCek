import 'package:flutter/material.dart';

final class DefaultTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final IconData? iconData;

  const DefaultTextField(
      {super.key,
      required this.title,
      required this.controller,
      this.iconData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: "Poppins Regular",
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          style: const TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(
            isDense: true,
            hintText: "Enter $title",
            hintStyle: const TextStyle(color: Colors.grey),
            prefixIcon: iconData == null
                ? null
                : Icon(iconData, color: Colors.grey), 
            fillColor: Colors.white, 
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10), 
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              
            ),
          ),
        ),
      ],
    );
  }
}
