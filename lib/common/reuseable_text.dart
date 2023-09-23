import 'package:flutter/material.dart';

class ReusableText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final int? maxLines;
  const ReusableText(
      {super.key, required this.text, required this.style, this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines ?? 1,
      textAlign: TextAlign.left,
      softWrap: false,
      overflow: TextOverflow.fade,
      style: style,
    );
  }
}
