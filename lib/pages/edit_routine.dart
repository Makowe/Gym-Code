import 'package:flutter/material.dart';
import 'package:gym_code/dialogs/rename_routine_dialog.dart';
import 'package:gym_code/l10n/app_localizations.dart';
import 'package:gym_code/widgets/button_group.dart';

import '../classes/routine.dart';
import '../classes/routine_element.dart';
import '../classes/rulesets/ruleset.dart';
import '../services/ruleset_service.dart';
import '../widgets/routine_result_card.dart';
import 'add_elements.dart';

class EditRoutine extends StatefulWidget {
  const EditRoutine({super.key, required this.routine, required this.isNew});

  final bool isNew;
  final Routine routine;

  @override
  State<EditRoutine> createState() => _EditRoutineState();
}

class _EditRoutineState extends State<EditRoutine> {
  late Routine routine;
  late bool isNew;

  late RuleSet ruleSet;

  _EditRoutineState();

  @override
  void initState() {
    // create a copy of the routine to allow cancelling of editing.
    routine = widget.routine.copy();
    isNew = widget.isNew;
    ruleSet = getRuleSetForApparatus(routine.apparatus);
    ruleSet.evaluateRoutine(routine);
    super.initState();

    if (isNew) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        renameRoutine();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    // The extended FAB's height is a fixed Material constraint (not
    // content-dependent like the card/button-group block's height), so it
    // can be read synchronously from the active theme instead of measured
    // post-frame.
    final double fabHeight = Theme.of(context)
            .floatingActionButtonTheme
            .extendedSizeConstraints
            ?.minHeight ??
        48.0;
    final double fabReservedHeight = fabHeight + kFloatingActionButtonMargin;

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(routine.getDisplayName(l10n)),
          leading: null,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.drive_file_rename_outline),
              onPressed: renameRoutine,
            )
          ],
        ),
        body: SafeArea(
          top: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 2.0),
              Expanded(
                child: ReorderableListView(
                    buildDefaultDragHandles: false,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    onReorderItem: (int oldIndex, int newIndex) {
                      setState(() {
                        final RoutineElement element =
                            routine.elements.removeAt(oldIndex);
                        routine.elements.insert(newIndex, element);
                        ruleSet.evaluateRoutine(routine);
                      });
                    },
                    children: <Widget>[
                      for (int i = 0; i < routine.elements.length; i++)
                        routine.elements[i].toWidget(
                            index: i, delete: deleteElement, allowEdit: true)
                    ]),
              ),
              // The FAB is embedded here (instead of via Scaffold.
              // floatingActionButton) so its position above this block is
              // correct from the very first layout pass, with no jump.
              // [fabReservedHeight] reserves real layout space for it
              // (rather than painting outside the Stack's bounds via a
              // negative offset), which is required for it to stay
              // tappable: a Positioned child painted outside its Stack's
              // own computed size is invisible to hit-testing even with
              // Clip.none, since RenderBox.hitTest gates on
              // `size.contains(position)` before delegating to children.
              Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: fabReservedHeight),
                      RoutineResultCard(routine: routine),
                      ButtonGroup([
                        ButtonSpec(
                            label: l10n.cancel,
                            color: colorScheme.secondaryContainer,
                            textColor: colorScheme.onSecondaryContainer,
                            onPressed: cancel,
                            icon: Icons.cancel),
                        ButtonSpec(
                            label: l10n.save,
                            color: colorScheme.primary,
                            textColor: colorScheme.onPrimary,
                            onPressed: save,
                            icon: Icons.save),
                      ]),
                    ],
                  ),
                  Positioned(
                    right: kFloatingActionButtonMargin,
                    top: 0,
                    child: FloatingActionButton.extended(
                      onPressed: addElements,
                      icon: const Icon(Icons.add),
                      label: Text(l10n.add),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void renameRoutine() async {
    String? newRoutineName = await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) =>
            RenameRoutineDialog(routineName: routine.name ?? ''));
    if (newRoutineName == null) {
      // user cancelled the renaming -> do nothing
    } else if (newRoutineName == '') {
      // user removed the name completely.
      setState(() {
        routine.name = null;
      });
    } else {
      // user gave a name
      setState(() {
        routine.name = newRoutineName;
      });
    }
  }

  void deleteElement(int idx) {
    setState(() {
      routine.elements.removeAt(idx);
      ruleSet.evaluateRoutine(routine);
    });
  }

  Future<void> addElements() async {
    final List<RoutineElement>? newElements = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddElements(apparatus: routine.apparatus),
      ),
    );
    if (newElements != null) {
      setState(() {
        routine.addElements(newElements);
        ruleSet.evaluateRoutine(routine);
      });
    }
  }

  void cancel() {
    // the routine changes are not saved but if a renaming was made,
    // it will be saved. Therefore, return routine name.
    Navigator.pop(context, routine.name);
  }

  void save() {
    Navigator.pop(context, routine);
  }
}
