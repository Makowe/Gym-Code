import 'package:flutter/material.dart';
import 'package:gym_code/l10n/app_localizations.dart';
import 'package:gym_code/theme/theme.dart';

class MissingDismountCard extends StatelessWidget {
  const MissingDismountCard({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final WarningColors warningColors =
        Theme.of(context).extension<WarningColors>()!;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        color: warningColors.warningContainer,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.warning_amber,
                color: warningColors.onWarningContainer,
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  l10n.routineMissingDismount,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: warningColors.onWarningContainer,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
