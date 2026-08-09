import 'package:flutter/material.dart';
import 'package:gym_code/l10n/app_localizations.dart';

import '../classes/apparatus.dart';

class ApparatusCard extends StatelessWidget {
  final Apparatus apparatus;
  final Function(Apparatus) view;

  const ApparatusCard({super.key, required this.apparatus, required this.view});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
      child: Material(
        color: Colors.grey[200],
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          splashColor: Colors.grey[500],
          child: Row(
            children: [
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  apparatus.localizedName(l10n),
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[900],
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    view(apparatus);
                  },
                  icon: const Icon(Icons.keyboard_arrow_right_sharp)),
            ],
          ),
          onTap: () {
            view(apparatus);
          },
        ),
      ),
    );
  }
}
