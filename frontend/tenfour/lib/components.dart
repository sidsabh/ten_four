import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final double width;
  final Color color;
  final VoidCallback onPressed;

  const ButtonWidget({
    Key? key,
    required this.title,
    required this.width,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        ),
        child: Text(title.toUpperCase()),
      ),
    );
  }
}
