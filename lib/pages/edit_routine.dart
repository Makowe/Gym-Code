import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../classes/routine.dart';
import '../classes/routine_element.dart';
import '../classes/rulesets/ruleset.dart';
import '../widgets/routine_result_card.dart';

class EditRoutine extends StatefulWidget {
  const EditRoutine({super.key, required this.routine});

  final Routine routine;

  @override
  State<EditRoutine> createState() => _EditRoutineState();
}

class _EditRoutineState extends State<EditRoutine> {
  late Routine routine;

  Ruleset ruleset = Ruleset();

  _EditRoutineState();

  @override
  void initState() {
    print('test1');
    print(widget);
    routine = widget.routine.copy();
    ruleset.evaluateRoutine(routine);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Routine'),
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
                      index: i,
                      delete: deleteElement,
                      allowEdit: true
                    )
                ]),
          ),
          FittedBox(
            child: FilledButton(
              onPressed: () {
                Navigator.pop(context, routine);
              },
              child: Row(
                children: [
                  Icon(Icons.save),
                  Text('Speichern')
                ],
              )
            ),
          ),
          RoutineResultCard(
              routine: routine
          ),
        ],
      ),
    );
  }

  void deleteElement(int idx) {
    setState(() {
      routine.elements.removeAt(idx);
      ruleset.evaluateRoutine(routine);
      print(routine);
    });
  }

}
