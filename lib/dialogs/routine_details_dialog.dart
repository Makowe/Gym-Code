import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gym_code/l10n/app_localizations.dart';
import 'package:gym_code/widgets/button_group.dart';
import 'package:gym_code/widgets/routine_result_card.dart';
import 'package:gym_code/widgets/routine_score_tables.dart';

import '../classes/apparatus.dart';
import '../classes/routine.dart';
import '../classes/rulebook.dart';

const TextStyle textStyleLarger = TextStyle(fontSize: 20.0);
const TextStyle textStyleDefault = TextStyle(fontSize: 16.0);
const TextStyle textStyleHeadline =
    TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold);

class RoutineDetailsDialog extends StatelessWidget {
  const RoutineDetailsDialog(this.routine, {super.key});

  final Routine routine;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Dialog(
      backgroundColor: colorScheme.surfaceContainerHighest,
      child: ConstrainedBox(
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.85),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    routine.apparatus.iconAsset,
                    width: 24.0,
                    height: 24.0,
                    colorFilter: ColorFilter.mode(
                        colorScheme.onSurface, BlendMode.srcIn),
                  ),
                  const SizedBox(width: 8.0),
                  Text(routine.apparatus.localizedName(l10n),
                      style: textStyleDefault),
                ],
              ),
              const SizedBox(height: 8),
              Text(routine.getDisplayName(l10n), style: textStyleLarger),
              const SizedBox(height: 4),
              Text(routine.rules.localizedName(l10n), style: textStyleDefault),
              const SizedBox(height: 12),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.elementsByValue, style: textStyleHeadline),
                      const SizedBox(height: 8),
                      DifficultyTable(routine: routine),
                      const SizedBox(height: 20),
                      Text(l10n.groups, style: textStyleHeadline),
                      const SizedBox(height: 8),
                      GroupsTable(routine: routine),
                      const SizedBox(height: 8),
                      RoutineResultCardContent(routine: routine),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ButtonGroup([
                ButtonSpec(
                    label: l10n.close,
                    icon: Icons.close,
                    onPressed: () =>
                        Navigator.of(context, rootNavigator: true).pop())
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
