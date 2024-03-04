import 'package:flutter/material.dart';

class TextTitleAuth extends StatelessWidget {
  final String text;
  const TextTitleAuth({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headline2,
    );
  }
}
