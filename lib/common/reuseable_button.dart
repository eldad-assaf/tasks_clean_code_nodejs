import 'package:flutter/material.dart';

class ReuseableButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? color;
  const ReuseableButton(
      {Key? key, required this.text, required this.onPressed, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Colors.blue,
        minimumSize: const Size(double.infinity, 50),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
