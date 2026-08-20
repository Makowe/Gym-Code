import 'package:flutter/material.dart';
import 'package:gym_code/classes/rulesets/ruleset.dart';
import 'package:gym_code/l10n/app_localizations.dart';
import 'package:gym_code/pages/edit_routine.dart';
import 'package:gym_code/services/routine_service.dart';

import '../classes/routine.dart';
import '../dialogs/confirm_delete_routine_dialog.dart';
import '../dialogs/routine_details_dialog.dart';
import '../services/ruleset_service.dart';
import '../widgets/routine_result_card.dart';

class ViewRoutine extends StatefulWidget {
  const ViewRoutine({super.key, required this.routine, this.isNew = false});

  final Routine routine;
  final bool isNew;

  @override
  State<ViewRoutine> createState() => _ViewRoutineState();
}

class _ViewRoutineState extends State<ViewRoutine> {
  late Routine routine;
  late bool isNew;

  late RuleSet ruleSet;

  @override
  void initState() {
    routine = widget.routine;

    isNew = widget.isNew;

    ruleSet = getRuleSetForApparatus(routine.apparatus);
    ruleSet.evaluateRoutine(routine);
    super.initState();

    if (isNew) {
      // call the routine editor automatically because the routine is empty.
      // Set the routine to not new anymore to prevent automatic editor a second time.
      isNew = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        editRoutine(isNew: true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);

    // The extended FAB's height is a fixed Material constraint (not
    // content-dependent like the result card's height), so it can be read
    // synchronously from the active theme instead of measured post-frame.
    final double fabHeight = Theme.of(context)
            .floatingActionButtonTheme
            .extendedSizeConstraints
            ?.minHeight ??
        48.0;
    final double fabReservedHeight = fabHeight + kFloatingActionButtonMargin;

    return Scaffold(
      appBar: AppBar(
        title: Text(routine.getDisplayName(l10n)),
        actions: [
          IconButton(
              onPressed: showDetails, icon: const Icon(Icons.info_outline)),
          IconButton(onPressed: beginDeletion, icon: const Icon(Icons.delete))
        ],
      ),
      body: SafeArea(
        top: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 2.0),
            Expanded(
              child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: <Widget>[
                    for (int i = 0; i < routine.elements.length; i++)
                      routine.elements[i].toWidget(index: i, allowEdit: false)
                  ]),
            ),
            // The FAB is embedded here (instead of via Scaffold.
            // floatingActionButton) so its position above the result card is
            // correct from the very first layout pass, with no jump.
            // [fabReservedHeight] reserves real layout space for it (rather
            // than painting outside the Stack's bounds via a negative
            // offset), which is required for it to stay tappable: a
            // Positioned child painted outside its Stack's own computed
            // size is invisible to hit-testing even with Clip.none, since
            // RenderBox.hitTest gates on `size.contains(position)` before
            // delegating to children.
            Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: fabReservedHeight),
                    RoutineResultCard(routine: routine),
                  ],
                ),
                Positioned(
                  right: kFloatingActionButtonMargin,
                  top: 0,
                  child: FloatingActionButton.extended(
                    onPressed: editRoutine,
                    icon: const Icon(Icons.edit),
                    label: Text(l10n.modify),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showDetails() async {
    showDialog(
        context: context, builder: (context) => RoutineDetailsDialog(routine));
  }

  Future<void> beginDeletion() async {
    bool deleteConfirmed = await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => ConfirmDeleteRoutineDialog(
            routine.getDisplayName(AppLocalizations.of(context))));
    if (deleteConfirmed) {
      if (routine.id != null) {
        deleteRoutine(routine.id!);
      }
      closeRoutine();
    }
  }

  void closeRoutine() {
    Navigator.of(context).pop();
  }

  Future<void> editRoutine({bool isNew = false}) async {
    final Object? retVal = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditRoutine(routine: routine, isNew: isNew),
      ),
    );
    setState(() {
      if (retVal is Routine) {
        // Editing was saved. Replace old routine with new routine.
        routine = retVal;
        storeRoutine(routine);
      } else {
        // Editing was discarded but renaming might have happened.
        routine.name = retVal as String?;
        if (routine.id != null) {
          // Only store permanently if the is not new.
          storeRoutine(routine);
        }
      }
    });
  }
}
