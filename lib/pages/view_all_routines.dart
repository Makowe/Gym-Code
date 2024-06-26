import 'package:flutter/material.dart';
import 'package:gym_code/pages/global_settings.dart';
import 'package:gym_code/pages/view_routine.dart';
import 'package:gym_code/services/routine_service.dart';
import 'package:gym_code/services/vocabulary_service.dart';
import 'package:gym_code/widgets/button_group.dart';

import '../classes/routine.dart';

class ViewAllRoutines extends StatefulWidget {
  const ViewAllRoutines({super.key});

  @override
  State<ViewAllRoutines> createState() => _ViewAllRoutinesState();
}

class _ViewAllRoutinesState extends State<ViewAllRoutines> {
  List<Routine> allRoutines = [];
  String headline = '';

  @override
  void initState() {
    loadHeadline();
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

  void loadHeadline() async {
    await Vocabulary.allRoutines.get().then((String value) {
      setState(() {
        headline = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(headline),
        actions: [
          IconButton(onPressed: openGlobalSettings, icon: const Icon(Icons.settings))
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
            ButtonSpec(vocabulary: Vocabulary.newRoutine, color: Colors.blue, onPressed: newRoutine,
            icon: Icons.add)
          ], refreshTextOnWidgetReload: true)
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
    bool settingsSaved = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const GlobalSettings())
    );

    if(settingsSaved) {
      loadHeadline();
    }
  }
}
