import 'package:flutter/material.dart';

import '../classes/routine.dart';

class RoutineCard extends StatelessWidget {
  final Routine routine;
  final int index;
  final Function view;

  const RoutineCard({
    super.key,
    required this.routine,
    required this.index,
    required this.view
  });

  @override
  Widget build(BuildContext context) {
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
                  routine.getDisplayName(),
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[900],
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    view(index);
                  },
                  icon: const Icon(Icons.keyboard_arrow_right_sharp)
              ),
            ],
          ),
          onTap: () { view(index); },
        ),
      ),
    );
  }
}
