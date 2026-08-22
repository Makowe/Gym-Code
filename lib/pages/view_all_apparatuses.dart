import 'package:flutter/material.dart';
import 'package:gym_code/l10n/app_localizations.dart';
import 'package:gym_code/pages/global_settings.dart';
import 'package:gym_code/pages/view_all_routines.dart';
import 'package:gym_code/widgets/apparatus_card.dart';

import '../classes/apparatus.dart';

class ViewAllApparatuses extends StatelessWidget {
  const ViewAllApparatuses({super.key});

  static const List<Apparatus> displayedApparatuses = [
    Apparatus.floor,
    Apparatus.pommelHorse,
    Apparatus.rings,
    Apparatus.parallelBars,
    Apparatus.horizontalBar,
  ];

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.allApparatuses),
        actions: [
          IconButton(
              onPressed: () => openGlobalSettings(context),
              icon: const Icon(Icons.settings))
        ],
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: <Widget>[
          for (Apparatus apparatus in displayedApparatuses)
            ApparatusCard(
                apparatus: apparatus,
                view: (apparatus) => viewApparatus(context, apparatus))
        ],
      ),
    );
  }

  void viewApparatus(BuildContext context, Apparatus apparatus) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewAllRoutines(apparatus: apparatus),
      ),
    );
  }

  void openGlobalSettings(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GlobalSettings()),
    );
  }
}
