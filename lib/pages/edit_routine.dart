import 'package:flutter/material.dart';
import 'package:gym_code/dialogs/rename_routine_dialog.dart';
import 'package:gym_code/services/vocabulary_service.dart';
import 'package:gym_code/widgets/button_group.dart';

import '../classes/routine.dart';
import '../classes/routine_element.dart';
import '../classes/rulesets/ruleset.dart';
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

  RuleSet ruleSet = RuleSet();
  String routineName = '';

  _EditRoutineState();


  @override
  void initState() {
    // create a copy of the routine to allow cancelling of editing.
    routine = widget.routine.copy();
    isNew = widget.isNew;
    ruleSet.evaluateRoutine(routine);
    super.initState();
    updateDisplayName();

    if (isNew) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        renameRoutine();
      });
    }
  }

  void updateDisplayName() {
    routine.getDisplayName().then((name) {
      setState(() {
        routineName = name;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(routineName),
          leading: null,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.drive_file_rename_outline),
              onPressed: renameRoutine,
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 2.0),
            Expanded(
              child: ReorderableListView(
                  buildDefaultDragHandles: false,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  onReorder: (int oldIndex, int newIndex) {
                    setState(() {
                      if (oldIndex < newIndex) {
                        newIndex -= 1;
                      }
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
            ButtonGroup([
              ButtonSpec(vocabulary: Vocabulary.cancel, color: Colors.red, onPressed: cancel, icon: Icons.cancel),
              ButtonSpec(vocabulary: Vocabulary.add, color: Colors.blue, onPressed: addElements, icon: Icons.add),
              ButtonSpec(vocabulary: Vocabulary.save, color: Colors.blue, onPressed: save, icon: Icons.save),
            ]),
            RoutineResultCard(routine: routine),
          ],
        ),
      ),
    );
  }

  void renameRoutine() async {
    String? newRoutineName = await showDialog(
      barrierDismissible: false,
        context: context,
        builder: (context) => RenameRoutineDialog(routineName: routine.name ?? '')
    );
    if(newRoutineName == null) {
      // user cancelled the renaming -> do nothing
    }
    else if(newRoutineName == '') {
      // user removed the name completely.
      setState(() {
        routine.name = null;
      });
    }
    else {
      // user gave a name
      setState(() {
        routine.name = newRoutineName;
        updateDisplayName();
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
        builder: (context) => const AddElements(),
      ),
    );
    if(newElements != null) {
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
