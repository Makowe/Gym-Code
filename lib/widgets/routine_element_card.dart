import 'package:flutter/material.dart';
import 'package:gym_code/dialogs/element_not_valued_dialog.dart';
import 'package:gym_code/dialogs/invalid_element_dialog.dart';
import 'package:gym_code/l10n/app_localizations.dart';
import 'package:gym_code/classes/routine_element.dart';
import 'package:gym_code/theme/theme.dart';
import 'package:gym_code/widgets/value_column.dart';

class RoutineElementCard extends StatelessWidget {
  final RoutineElement element;
  final Function? delete;
  final bool allowEdit;
  final int index;

  const RoutineElementCard(
      {super.key,
      required this.index,
      required this.element,
      required this.allowEdit,
      this.delete});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final WarningColors warningColors =
        Theme.of(context).extension<WarningColors>()!;

    final Color backgroundColor;
    final Color contentColor;
    if (!element.isValid) {
      backgroundColor = warningColors.warningContainer;
      contentColor = warningColors.onWarningContainer;
    } else if (!element.isValued) {
      backgroundColor = colorScheme.surfaceContainerHigh;
      contentColor = colorScheme.onSurfaceVariant;
    } else {
      backgroundColor = colorScheme.tertiaryContainer;
      contentColor = colorScheme.onTertiaryContainer;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        color: backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ValueColumn(
              value: element.difficulty,
              description: l10n.value,
              color: contentColor,
            ),
            ValueColumn(
              value: element.group.toString(),
              description: l10n.group,
              color: contentColor,
            ),
            Expanded(
              child: Text(
                element.localizedName(
                    Localizations.localeOf(context).languageCode),
                style: TextStyle(
                  fontSize: 16.0,
                  color: contentColor,
                ),
              ),
            ),
            if (!element.isValid)
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => InvalidElementDialog(
                        element.getInvalidReasonText(l10n)),
                  );
                },
                icon: Icon(
                  Icons.warning_amber,
                  color: contentColor,
                ),
              ),
            if (element.isValid && !element.isValued)
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const ElementNotValuedDialog(),
                  );
                },
                icon: Icon(
                  Icons.info_outline,
                  color: contentColor,
                ),
              ),
            allowEdit
                ? Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (delete != null) {
                            delete!(index);
                          }
                        },
                        icon: Icon(
                          Icons.delete,
                          color: colorScheme.error,
                        ),
                      ),
                      ReorderableDragStartListener(
                          index: index,
                          child: IconButton(
                            enableFeedback: true,
                            onPressed: () {
                              // do nothing
                            },
                            icon: Icon(
                              Icons.drag_handle,
                              color: colorScheme.onSecondaryContainer,
                            ),
                          ))
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
