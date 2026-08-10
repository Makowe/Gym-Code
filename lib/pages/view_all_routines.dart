import 'package:flutter/material.dart';
import 'package:gym_code/l10n/app_localizations.dart';
import 'package:gym_code/pages/view_routine.dart';
import 'package:gym_code/services/routine_service.dart';
import 'package:gym_code/widgets/button_group.dart';

import '../classes/apparatus.dart';
import '../classes/routine.dart';

class ViewAllRoutines extends StatefulWidget {
  const ViewAllRoutines({super.key, required this.apparatus});

  final Apparatus apparatus;

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
        allRoutines = routines
            .where((routine) => routine.apparatus == widget.apparatus)
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.apparatus.localizedName(l10n)),
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
              for (int i = 0; i < allRoutines.length; i++)
                allRoutines[i].toWidget(i, viewRoutine)
            ],
          )),
          ButtonGroup([
            ButtonSpec(
                label: l10n.newRoutine,
                color: colorScheme.primary,
                textColor: colorScheme.onPrimary,
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
    loadAllRoutines();
  }

  void newRoutine() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewRoutine(
          routine: Routine(apparatus: widget.apparatus, elements: []),
          isNew: true,
        ),
      ),
    );
    // update routines in case of changes
    loadAllRoutines();
  }
}
