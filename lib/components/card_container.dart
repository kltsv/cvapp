import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class CVCardContainer extends StatelessWidget {
  final Widget front;
  final Widget? back;

  const CVCardContainer({
    super.key,
    required this.front,
    this.back,
  });

  @override
  Widget build(BuildContext context) {
    final frontContainer = _CardContainer(child: front);
    final child = back != null
        ? FlipCard(
            side: CardSide.FRONT,
            direction: FlipDirection.HORIZONTAL,
            fill: Fill.fillBack,
            front: frontContainer,
            back: _CardContainer(child: back ?? const SizedBox.shrink()),
          )
        : frontContainer;
    return AspectRatio(
      aspectRatio: 1.8,
      child: child,
    );
  }
}

class _CardContainer extends StatelessWidget {
  static const _borderRadius = 16.0;

  final Widget child;

  const _CardContainer({required this.child});

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
