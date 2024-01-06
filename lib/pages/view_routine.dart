import 'package:flutter/material.dart';
import 'package:gym_code/classes/rulesets/ruleset.dart';
import 'package:gym_code/pages/edit_routine.dart';
import 'package:gym_code/services/routine_service.dart';

import '../classes/routine.dart';
import '../widgets/routine_result_card.dart';

class ViewRoutine extends StatefulWidget {
  const ViewRoutine({super.key, required this.routine});

  final Routine routine;

  @override
  State<ViewRoutine> createState() => _ViewRoutineState();
}

class _ViewRoutineState extends State<ViewRoutine> {
  late Routine routine;

  RuleSet ruleSet = RuleSet();

  @override
  void initState() {
    routine = widget.routine;
    ruleSet.evaluateRoutine(routine);
    super.initState();
  }

  _ViewRoutineState();

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
    final Routine? routineEdited = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditRoutine(routine: routine),
      ),
    );
    setState(() {
      if (routineEdited != null) {
        // transfer the id of old routine to new routine. Then replace old
        // routine with new routine.
        routineEdited.id = routine.id;
        routine = routineEdited;
        storeRoutine(routine);
      }
    });
  }
}
