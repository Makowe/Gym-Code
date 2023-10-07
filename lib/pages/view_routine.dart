import 'package:flutter/material.dart';
import 'package:gym_code/classes/rulesets/ruleset.dart';
import 'package:gym_code/pages/edit_routine.dart';

import '../classes/routine.dart';
import '../constants/element_list_pommel_horse.dart';
import '../widgets/routine_result_card.dart';

class ViewRoutine extends StatefulWidget {
  const ViewRoutine({super.key});

  @override
  State<ViewRoutine> createState() => _ViewRoutineState();
}

class _ViewRoutineState extends State<ViewRoutine> {
  Routine routine = Routine(elements: [
    p_1_1,
    p_1_3,
    p_1_7,
    p_1_8,
    p_1_13,
    p_2_1,
    p_2_92,
    p_3_1,
    // p_4_1,
    // p_n_1,
    // p_n_22,
  ]);

  Ruleset ruleset = Ruleset();

  _ViewRoutineState() {
    ruleset.evaluateRoutine(routine);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Routine'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: <Widget>[
                  for (int i = 0; i < routine.elements.length; i++)
                    routine.elements[i].toWidget(index: i, allowEdit: false)
                ]),
          ),
          FilledButton(
              onPressed: () {
                editRoutine();
              },
              child: const FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.edit), Text('Bearbeiten')],
                ),
              )),
          RoutineResultCard(routine: routine),
        ],
      ),
    );
  }

  Future<void> editRoutine() async {
    final Routine routineEdited = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditRoutine(routine: routine),
      ),
    );
    setState(() {
      routine = routineEdited;
    });
  }
}
