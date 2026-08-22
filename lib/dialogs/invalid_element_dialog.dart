import 'package:flutter/material.dart';
import 'package:gym_code/l10n/app_localizations.dart';
import 'package:gym_code/widgets/button_group.dart';

class InvalidElementDialog extends StatelessWidget {
  const InvalidElementDialog(this.reasonText, {super.key});

  final String reasonText;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);

    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(l10n.invalidElement,
                style: const TextStyle(fontSize: 20.0)),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(reasonText),
          ),
          const SizedBox(height: 12),
          ButtonGroup([
            ButtonSpec(
                label: l10n.close,
                icon: Icons.close,
                onPressed: () => Navigator.pop(context)),
          ]),
        ],
      ),
    );
  }
}
