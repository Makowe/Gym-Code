import 'package:flutter/material.dart';

enum ButtonType {
  filledPrimary,
  filledSecondary,
  filledError,
  outlinedPrimary,
  outlinedSecondary,
  textPrimary,
  textSecondary
}

class ButtonSpec {
  const ButtonSpec({
    this.type = ButtonType.filledSecondary,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final ButtonType type;
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
}

Widget _buildButtonContent(ButtonSpec spec) {
  return Row(
    children: [
      if (spec.icon != null) Icon(spec.icon),
      if (spec.icon != null) const SizedBox(width: 4),
      Text(spec.label),
    ],
  );
}

Widget _buildButton(ButtonSpec spec, ColorScheme colorScheme) {
  if (spec.type == ButtonType.filledPrimary ||
      spec.type == ButtonType.filledSecondary ||
      spec.type == ButtonType.filledError) {
    Color backgroundColor;
    Color foregroundColor;
    if (spec.type == ButtonType.filledPrimary) {
      backgroundColor = colorScheme.primary;
      foregroundColor = colorScheme.onPrimary;
    } else if (spec.type == ButtonType.filledSecondary) {
      backgroundColor = colorScheme.secondary;
      foregroundColor = colorScheme.onSecondary;
    } else {
      backgroundColor = colorScheme.error;
      foregroundColor = colorScheme.onError;
    }

    return FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
        ),
        onPressed: spec.onPressed,
        child: _buildButtonContent(spec));
  } else if (spec.type == ButtonType.outlinedPrimary ||
      spec.type == ButtonType.outlinedSecondary) {
    Color foregroundColor;
    if (spec.type == ButtonType.filledPrimary) {
      foregroundColor = colorScheme.primary;
    } else {
      foregroundColor = colorScheme.secondary;
    }

    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: foregroundColor,
        ),
        onPressed: spec.onPressed,
        child: _buildButtonContent(spec));
  } else {
    Color foregroundColor;
    if (spec.type == ButtonType.textPrimary) {
      foregroundColor = colorScheme.primary;
    } else {
      foregroundColor = colorScheme.secondary;
    }

    return TextButton(
        style: TextButton.styleFrom(
          foregroundColor: foregroundColor,
        ),
        onPressed: spec.onPressed,
        child: _buildButtonContent(spec));
  }
}

class ButtonGroup extends StatelessWidget {
  const ButtonGroup(this.buttonSpecs, {super.key});

  final List<ButtonSpec> buttonSpecs;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.center,
      children: [
        for (ButtonSpec spec in buttonSpecs)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 0.0),
            child: FittedBox(child: _buildButton(spec, colorScheme)),
          ),
      ],
    );
  }
}
