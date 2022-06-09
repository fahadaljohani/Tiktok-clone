import 'package:flutter/material.dart';

class ShowIcon extends StatelessWidget {
  final VoidCallback onTap;
  final IconData iconData;
  final String content;
  final Color color;
  const ShowIcon(
      {Key? key,
      required this.onTap,
      required this.iconData,
      required this.content,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Icon(
            iconData,
            size: 35,
            color: color,
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        Text(
          content,
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.bold, color: color),
        ),
      ],
    );
  }
}
