import 'package:flutter/material.dart';
import 'package:gym_code/dialogs/routine_settings_dialog.dart';
import 'package:gym_code/l10n/app_localizations.dart';
import 'package:gym_code/widgets/button_group.dart';

import '../classes/routine.dart';
import '../classes/routine_element.dart';
import '../classes/rulebook.dart';
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
    ruleSet = getRuleSetForApparatus(routine.apparatus, routine.rules);
    ruleSet.evaluateRoutine(routine);
    super.initState();

    if (isNew) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        openRoutineSettings();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);

    // The extended FAB's height is a fixed Material constraint (not
    // content-dependent like the card/button-group block's height), so it
    // can be read synchronously from the active theme instead of measured
    // post-frame.
    // `floatingActionButtonTheme.extendedSizeConstraints` is null unless the
    // app theme overrides it, so the fallback here must match Flutter's own
    // Material 3 default (56.0), not the older Material 2 default (48.0) -
    // otherwise the reserved space undershoots the FAB's real height.
    final double fabHeight = Theme.of(context)
            .floatingActionButtonTheme
            .extendedSizeConstraints
            ?.minHeight ??
        56.0;
    final double fabReservedHeight =
        fabHeight + kFloatingActionButtonMargin / 2;

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(routine.getDisplayName(l10n)),
          leading: null,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: openRoutineSettings,
            )
          ],
        ),
        body: SafeArea(
          top: false,
          child: Column(
            children: [
              const SizedBox(height: 2.0),
              // The element list and the FAB share this Stack so the list
              // scrolls underneath the button instead of stopping short
              // and leaving a dedicated empty gap above the result card.
              // The list's bottom padding ([fabReservedHeight]) keeps the
              // last elements scrollable clear of the FAB rather than
              // permanently hidden behind it.
              Expanded(
                child: Stack(
                  children: [
                    ReorderableListView(
                        buildDefaultDragHandles: false,
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.only(bottom: fabReservedHeight),
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
                                index: i,
                                delete: deleteElement,
                                allowEdit: true)
                        ]),
                    Positioned(
                      right: kFloatingActionButtonMargin,
                      bottom: kFloatingActionButtonMargin / 2,
                      child: FloatingActionButton.extended(
                        onPressed: addElements,
                        icon: const Icon(Icons.add),
                        label: Text(l10n.add),
                      ),
                    ),
                  ],
                ),
              ),
              RoutineResultCard(routine: routine),
              ButtonGroup([
                ButtonSpec(
                    type: ButtonType.textSecondary,
                    label: l10n.cancel,
                    onPressed: cancel,
                    icon: Icons.cancel),
                ButtonSpec(label: l10n.save, onPressed: save, icon: Icons.save),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  void openRoutineSettings() async {
    final (String, Rulebook)? result = await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => RoutineSettingsDialog(
            routineName: routine.name ?? '', rulebook: routine.rules));
    if (result == null) {
      // user cancelled the routine settings -> do nothing
      return;
    }
    final (String newRoutineName, Rulebook newRulebook) = result;
    setState(() {
      // an empty name means the user removed the name completely.
      routine.name = newRoutineName == '' ? null : newRoutineName;
      routine.rules = newRulebook;
      ruleSet = getRuleSetForApparatus(routine.apparatus, routine.rules);
      ruleSet.evaluateRoutine(routine);
    });
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
        builder: (context) => AddElements(
          apparatus: routine.apparatus,
          rulebook: routine.rules,
        ),
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
    // the routine changes are not saved but if the routine settings
    // (name/rulebook) were changed, they will be saved. Therefore, return
    // routine name and rulebook.
    Navigator.pop(context, (routine.name, routine.rules));
  }

  void save() {
    Navigator.pop(context, routine);
  }
}
