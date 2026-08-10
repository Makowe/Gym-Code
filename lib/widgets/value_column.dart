import 'package:flutter/material.dart';

class ValueColumn extends StatelessWidget {
  final String value;
  final String description;
  final bool greyedOut;

  const ValueColumn(
      {super.key,
      required this.value,
      required this.description,
      this.greyedOut = false});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color color = greyedOut
        ? colorScheme.onSecondaryContainer.withValues(alpha: 0.5)
        : colorScheme.onSecondaryContainer;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(fontSize: 20.0, color: color),
          ),
          Text(
            description,
            style: TextStyle(fontSize: 12.0, color: color),
          )
        ],
      ),
    );
  }
}
