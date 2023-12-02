import 'package:flutter/material.dart';
import 'package:gym_code/classes/routine_element.dart';
import 'package:gym_code/widgets/value_column.dart';

class RoutineElementCard extends StatelessWidget {
  final RoutineElement element;
  final Function? delete;
  final bool allowEdit;
  final int index;

  const RoutineElementCard(
      {super.key,
      required this.index,
      required this.element,
      required this.allowEdit,
      this.delete});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Column(
        children: [
          const Divider(
            height: 1.5,
            thickness: 1.5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ValueColumn(
                value: element.difficulty,
                description: 'Wert',
                greyedOut: !element.isValued,
              ),
              ValueColumn(
                value: element.group.toString(),
                description: 'Gruppe',
                greyedOut: !element.isValued,
              ),
              Expanded(
                child: Text(
                  element.name['de']!,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: element.isValued ? Colors.grey[900] : Colors.grey[400],
                  ),
                ),
              ),
              allowEdit
                  ? Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            if (delete != null) {
                              delete!(index);
                            }
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red[800],
                          ),
                        ),
                      ReorderableDragStartListener(
                          index: index,
                          child: IconButton(
                            enableFeedback: true,
                            onPressed: () {
                              // do nothing
                            },
                            icon: const Icon(
                            Icons.drag_handle,
                            color: Colors.black,
                            ),
                          )
                      )
                    ],
                  )
                  : const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
