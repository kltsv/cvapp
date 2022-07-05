import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  static const fontSize = 28.0;

  final String value;

  const AppTitle(this.value, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: const TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class AppSubtitle extends StatelessWidget {
  static const fontSize = 18.0;

  final String value;

  const AppSubtitle(this.value, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: const TextStyle(fontSize: fontSize),
    );
  }
}

class AppText extends StatelessWidget {
  static const fontSize = 14.0;

  final String value;

  const AppText(this.value, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: const TextStyle(fontSize: fontSize),
    );
  }
}
