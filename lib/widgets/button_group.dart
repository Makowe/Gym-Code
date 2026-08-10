import 'package:flutter/material.dart';

class ButtonSpec {
  const ButtonSpec({
    required this.label,
    required this.color,
    required this.textColor,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final IconData? icon;
}

class ButtonGroup extends StatelessWidget {
  const ButtonGroup(this.buttonSpecs, {super.key});

  final List<ButtonSpec> buttonSpecs;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.center,
      children: [
        for (ButtonSpec spec in buttonSpecs)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 0.0),
            child: FittedBox(
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: spec.color,
                  foregroundColor: spec.textColor,
                ),
                onPressed: spec.onPressed,
                child: Row(
                  children: [
                    if (spec.icon is IconData) Icon(spec.icon),
                    Text(spec.label),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
