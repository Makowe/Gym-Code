import 'package:flutter/material.dart';
import 'package:gym_code/services/vocabulary_service.dart';

class ButtonState {
  ButtonState(this.spec);

  final ButtonSpec spec;
  String text = '';
}

class ButtonSpec {
  ButtonSpec(
      {required this.vocabulary, required this.color, required this.icon, required this.onPressed});

  final Vocabulary vocabulary;
  final Function onPressed;
  final Color color;
  final IconData? icon;
}

class ButtonGroup extends StatefulWidget {
  const ButtonGroup(this.buttonSpecs, {super.key, this.refreshTextOnWidgetReload = false});

  final List<ButtonSpec> buttonSpecs;

  // Usually, the Text of the ButtonGroup is loaded during initialization and not changed afterwards.
  // If a Button is generated before changing language and still exists after changing language,
  // the text would not be updated. This flag allows text update during lifecycle of Widget.
  final bool refreshTextOnWidgetReload;

  @override
  State<ButtonGroup> createState() => _ButtonGroupState();
}

class _ButtonGroupState extends State<ButtonGroup> {
  List<ButtonState> buttons = [];

  @override
  void didUpdateWidget(covariant ButtonGroup oldWidget) {
    if(widget.refreshTextOnWidgetReload) {
      loadButtonTexts();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    loadButtonTexts();
    super.initState();
  }

  void loadButtonTexts() {
    buttons = [];
    for(ButtonSpec buttonSpec in widget.buttonSpecs) {
      ButtonState button = ButtonState(buttonSpec);
      buttons.add(button);

      // Get button Text from vocabulary service.
      // When Service responds, update button
      buttonSpec.vocabulary.get().then((text) {
        setState(() {
          button.text = text;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.center,
      children: [
        for(ButtonState button in buttons)
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 2.0, vertical: 0.0
            ),
            child: FittedBox(
              child: FilledButton(
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(button.spec.color),
                  textStyle: const WidgetStatePropertyAll(TextStyle(color: Colors.white)),
                ),
                onPressed: () => button.spec.onPressed(),
                child: Row(
                  children: [
                    if(button.spec.icon is IconData) Icon(button.spec.icon),
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
