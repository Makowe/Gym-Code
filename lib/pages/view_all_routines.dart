import 'package:flutter/material.dart';
import 'package:gym_code/l10n/app_localizations.dart';
import 'package:gym_code/pages/global_settings.dart';
import 'package:gym_code/pages/view_routine.dart';
import 'package:gym_code/services/routine_service.dart';
import 'package:gym_code/widgets/button_group.dart';

import '../classes/routine.dart';

class ViewAllRoutines extends StatefulWidget {
  const ViewAllRoutines({super.key});

  @override
  State<ViewAllRoutines> createState() => _ViewAllRoutinesState();
}

class _ViewAllRoutinesState extends State<ViewAllRoutines> {
  List<Routine> allRoutines = [];

  @override
  void initState() {
    loadAllRoutines();
    super.initState();
  }

  void loadAllRoutines() async {
    await getAllRoutines().then((routines) {
      setState(() {
        allRoutines = routines;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.allRoutines),
        actions: [
          IconButton(
              onPressed: openGlobalSettings, icon: const Icon(Icons.settings))
        ],
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
          ButtonGroup([
            ButtonSpec(
                label: l10n.newRoutine,
                color: Colors.blue,
                onPressed: newRoutine,
                icon: Icons.add)
          ])
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

  void openGlobalSettings() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GlobalSettings()),
    );
  }
}
