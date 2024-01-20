import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

import 'card_container.dart';

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
    final frontContainer = CardContainer(child: front);
    final child = back != null
        ? FlipCard(
            side: CardSide.FRONT,
            direction: FlipDirection.HORIZONTAL,
            fill: Fill.fillBack,
            front: frontContainer,
            back: CardContainer(child: back ?? const SizedBox.shrink()),
          )
        : frontContainer;
    return AspectRatio(
      aspectRatio: 1.8,
      child: child,
    );
  }
}
