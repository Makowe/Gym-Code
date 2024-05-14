import 'package:flutter/material.dart';
import 'package:gym_code/pages/view_routine.dart';
import 'package:gym_code/services/routine_service.dart';
import 'package:gym_code/widgets/new_routine_card.dart';

import '../classes/routine.dart';

class ViewAllRoutines extends StatefulWidget {
  const ViewAllRoutines({super.key});

  @override
  State<ViewAllRoutines> createState() => _ViewAllRoutinesState();
}

class _ViewAllRoutinesState extends State<ViewAllRoutines> {
  List<Routine> allRoutines = [];

  _ViewAllRoutinesState() {
    Future<List<Routine>> futureRoutines = getAllRoutines();
    futureRoutines.then((routines) {
      setState(() {
        allRoutines = routines;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alle Übungen'),
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
                  for(int i = 0; i < allRoutines.length; i++)
                    allRoutines[i].toWidget(i, viewRoutine)
                ],
              )
          ),
          NewRoutineCard(add: newRoutine),
        ],
      ),
    );
  }

  void viewRoutine(int index) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewRoutine(routine: allRoutines[index]),
      ),
    );
    // update routines in case of changes
    Future<List<Routine>> futureRoutines = getAllRoutines();
    futureRoutines.then((routines) {
      setState(() {
        allRoutines = routines;
      });
    });
  }

  void newRoutine() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewRoutine(routine: Routine(elements: []), isNew: true,),
      ),
    );
    // update routines in case of changes
    Future<List<Routine>> futureRoutines = getAllRoutines();
    futureRoutines.then((routines) {
      setState(() {
        allRoutines = routines;
      });
    });
  }
}
