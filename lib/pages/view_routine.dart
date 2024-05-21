import 'package:flutter/material.dart';
import 'package:gym_code/classes/rulesets/ruleset.dart';
import 'package:gym_code/pages/edit_routine.dart';
import 'package:gym_code/services/routine_service.dart';
import 'package:gym_code/widgets/button_group.dart';

import '../classes/routine.dart';
import '../dialogs/confirm_delete_routine_dialog.dart';
import '../dialogs/routine_details_dialog.dart';
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

  RuleSet ruleSet = RuleSet();

  @override
  void initState() {
    routine = widget.routine;
    isNew = widget.isNew;

    ruleSet.evaluateRoutine(routine);
    super.initState();

    if(isNew) {
      // call the routine editor automatically because the routine is empty.
      // Set the routine to not new anymore to prevent automatic editor a second time.
      isNew = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        editRoutine(isNew: true);
      });
    }
  }

  _ViewRoutineState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(routine.getDisplayName()),
        actions: [
          IconButton(
            onPressed: showDetails,
            icon: const Icon(Icons.info_outline)),
          IconButton(
              onPressed: beginDeletion,
              icon: const Icon(Icons.delete))
        ],
      ),
      body: Column(
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
          ButtonGroup(buttons: [
            ButtonSpec(text: "Bearbeiten", color: Colors.blue, onPressed: editRoutine,
            icon: Icons.edit)
          ]),
          RoutineResultCard(routine: routine),
        ],
      ),
    );
  }

  Future<void> showDetails() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return createDetailsDialog(context, routine);
    });
  }

  Future<void> beginDeletion() async {
    bool deleteConfirmed = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => ConfirmDeleteRoutineDialog(routineName: routine.getDisplayName())
    );
    if(deleteConfirmed) {
      if(routine.id != null) {
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
      }
      else {
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
