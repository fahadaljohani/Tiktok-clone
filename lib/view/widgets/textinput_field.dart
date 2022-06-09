import 'package:flutter/material.dart';
import 'package:tiktok_clone2/constant.dart';

class TextinputField extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  final IconData icon;
  final String labelText;
  final bool isObsecure;
  TextinputField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.icon,
    this.isObsecure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isObsecure,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          fontSize: 15,
        ),
        prefixIcon: Icon(icon),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor,
          ),
        ),
      ),
    );
  }
}
