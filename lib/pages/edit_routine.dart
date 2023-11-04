import 'package:flutter/material.dart';

import '../classes/routine.dart';
import '../classes/routine_element.dart';
import '../classes/rulesets/ruleset.dart';
import '../widgets/routine_result_card.dart';
import 'add_elements.dart';

class EditRoutine extends StatefulWidget {
  const EditRoutine({super.key, required this.routine});

  final Routine routine;

  @override
  State<EditRoutine> createState() => _EditRoutineState();
}

class _EditRoutineState extends State<EditRoutine> {
  late Routine routine;

  RuleSet ruleset = RuleSet();

  _EditRoutineState();

  @override
  void initState() {
    routine = widget.routine.copy();
    ruleset.evaluateRoutine(routine);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Übung bearbeiten'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ReorderableListView(
                buildDefaultDragHandles: true,
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
                    ruleset.evaluateRoutine(routine);
                  });
                },
                children: <Widget>[
                  for (int i = 0; i < routine.elements.length; i++)
                    routine.elements[i].toWidget(
                        index: i, delete: deleteElement, allowEdit: true)
                ]),
          ),
          FittedBox(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 2.0, vertical: 0.0),
                  child: FilledButton(
                      onPressed: () {
                        discard();
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.red[600])),
                      child: const Row(
                        children: [Icon(Icons.cancel), Text('Abbrechen')],
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 2.0, vertical: 0.0),
                  child: FilledButton(
                      onPressed: () {
                        addElements();
                      },
                      child: const Row(
                        children: [Icon(Icons.add), Text('Hinzufügen')],
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 2.0, vertical: 0.0),
                  child: FilledButton(
                      onPressed: () {
                        save();
                      },
                      child: const Row(
                        children: [Icon(Icons.save), Text('Speichern')],
                      )),
                ),
              ],
            ),
          ),
          RoutineResultCard(routine: routine),
        ],
      ),
    );
  }

  void deleteElement(int idx) {
    setState(() {
      routine.elements.removeAt(idx);
      ruleset.evaluateRoutine(routine);
    });
  }

  Future<void> addElements() async {
    final List<RoutineElement> newElements = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddElements(),
      ),
    );
    setState(() {
      routine.addElements(newElements);
      ruleset.evaluateRoutine(routine);
    });
  }

  void discard() {
    Navigator.pop(context, null);
  }

  void save() {
    Navigator.pop(context, routine);
  }
}
