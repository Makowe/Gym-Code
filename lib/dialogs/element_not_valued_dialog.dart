import 'package:flutter/material.dart';
import 'package:gym_code/l10n/app_localizations.dart';
import 'package:gym_code/widgets/button_group.dart';

class ElementNotValuedDialog extends StatelessWidget {
  const ElementNotValuedDialog({super.key});

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
            child: Text(l10n.elementNotValuedInfo),
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
