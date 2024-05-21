import 'package:flutter/material.dart';

import '../classes/routine.dart';

class RoutineCard extends StatefulWidget {
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
  State<RoutineCard> createState() => _RoutineCardState();
}

class _RoutineCardState extends State<RoutineCard> {
  String routineName = '';

  @override
  void didUpdateWidget(covariant RoutineCard oldWidget) {
    updateDisplayName();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    updateDisplayName();
    super.initState();
  }

  void updateDisplayName() {
    widget.routine.getDisplayName().then((name) {
      setState(() {
        routineName = name;
      });
    });
  }

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
                  routineName,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[900],
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    widget.view(widget.index);
                  },
                  icon: const Icon(Icons.keyboard_arrow_right_sharp)
              ),
            ],
          ),
          onTap: () { widget.view(widget.index); },
        ),
      ),
    );
  }
}
