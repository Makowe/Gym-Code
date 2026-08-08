import 'package:flutter/material.dart';
import 'package:gym_code/l10n/app_localizations.dart';

import '../classes/routine_element.dart';

class RoutineElementCompact extends StatelessWidget {
  final RoutineElement element;
  final Function add;

  const RoutineElementCompact(
      {super.key, required this.element, required this.add});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 6.0, vertical: 0.0),
              child: Text(
                element.difficulty,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 6.0, vertical: 0.0),
              child: Text(
                element.group.toString(),
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6.0, vertical: 0.0),
                child: Text(
                  element.localizedName(
                      Localizations.localeOf(context).languageCode),
                  style: TextStyle(fontSize: 16.0, color: Colors.grey[900]),
                ),
              ),
            ),
            SizedBox(
              height: 36.0,
              width: 36.0,
              child: IconButton(
                onPressed: () {
                  add(element);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(AppLocalizations.of(context).elementAdded),
                      duration: const Duration(milliseconds: 1000)));
                },
                icon: const Icon(Icons.add),
                padding: const EdgeInsets.all(0.0),
              ),
            )
          ],
        ),
        const Divider()
      ],
    );
  }
}
