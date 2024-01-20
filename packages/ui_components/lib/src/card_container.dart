
import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  static const _borderRadius = 16.0;

  final Widget child;

  const CardContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      elevation: 8.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_borderRadius),
        child: child,
      ),
    );
  }
}
