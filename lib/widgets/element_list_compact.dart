import 'package:flutter/material.dart';
import 'package:gym_code/widgets/routine_element_compact.dart';

import '../classes/routine_element.dart';

class ElementListCompact extends StatelessWidget {
  final List<RoutineElement> elements;
  final Function add;

  const ElementListCompact(
      {super.key, required this.elements, required this.add});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Divider(),
            for (int i = 0; i < elements.length; i++)
              RoutineElementCompact(element: elements[i], add: add)
          ],
        ),
      ),
    );
  }
}
