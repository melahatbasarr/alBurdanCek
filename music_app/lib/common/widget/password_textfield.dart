import 'package:flutter/material.dart';

final class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String title;

  const PasswordTextField({
    super.key,
    required this.title,
    required this.controller,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

final class _PasswordTextFieldState extends State<PasswordTextField> {
  bool visibility = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: "Poppins Regular",
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: widget.controller,
          obscureText: !visibility,
          style: const TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(
            isDense: true,
            hintText: "Enter ${widget.title}",
            hintStyle: const TextStyle(color: Colors.grey),
            prefixIcon: const Icon(
              Icons.lock_outline,
              color: Colors.grey,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  visibility = !visibility;
                });
              },
              icon: Icon(
                visibility ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
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
