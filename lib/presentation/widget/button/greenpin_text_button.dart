
import 'package:flutter/cupertino.dart';

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
    return CupertinoButton(
      onPressed: onPressed,
      child: Text(
        text,
      style: style,
      ),
    );
  }
}