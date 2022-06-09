import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {
  final String message;
  const ProgressDialog({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              const SizedBox(
                width: 6,
              ),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
              const SizedBox(
                width: 26,
              ),
              Text(
                message,
                style: const TextStyle(fontSize: 13, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
