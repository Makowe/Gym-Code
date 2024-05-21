import 'package:flutter/material.dart';

class ButtonSpec {
  const ButtonSpec(
      {required this.text, required this.color, required this.icon, required this.onPressed});

  final String text;
  final Function onPressed;
  final Color color;
  final IconData? icon;
}

class ButtonGroup extends StatelessWidget {
  const ButtonGroup({super.key, required this.buttons });

  final List<ButtonSpec> buttons;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.center,
      children: [
        for(ButtonSpec button in buttons)
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 2.0, vertical: 0.0
            ),
            child: FittedBox(
              child: FilledButton(
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(button.color),
                  textStyle: const WidgetStatePropertyAll(TextStyle(color: Colors.white)),
                ),
                onPressed: () => button.onPressed(),
                child: Row(
                  children: [
                    if(button.icon is IconData) Icon(button.icon),
                    Text(button.text),
                  ],
                ),

              ),
            ),
          ),

      ],
    );
  }
}
