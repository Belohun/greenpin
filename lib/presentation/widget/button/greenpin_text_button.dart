
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GreenpinTextButton extends StatelessWidget {
  const GreenpinTextButton({
    required this.text,
    this.onPressed,
    this.style,
    Key? key,
  }) : super(key: key);
  final VoidCallback? onPressed;
  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Text(
        text,
      style: style,
      ),
    );
  }
}