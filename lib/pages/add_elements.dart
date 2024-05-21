import 'package:flutter/material.dart';
import 'package:gym_code/classes/routine_element.dart';
import 'package:gym_code/widgets/button_group.dart';

import '../services/element_service.dart';
import '../widgets/element_list_compact.dart';

class AddElements extends StatefulWidget {
  const AddElements({super.key});

  @override
  State<AddElements> createState() => _AddElementsState();
}

class _AddElementsState extends State<AddElements> {
  static const List<String> filterDifficultyOptions = [
    'NE',
    'A',
    'B',
    'C',
    'D',
    'E',
    'F+'
  ];
  static const List<int> filterGroupOptions = [1, 2, 3, 4];

  Set<String> filterDifficulty = {};
  Set<num> filterGroup = {};

  List<RoutineElement> allElements = [];
  List<RoutineElement> filteredElements = [];
  List<RoutineElement> elementsToAdd = [];

  _AddElementsState() {
    Future<List<RoutineElement>> futureElements = getAllElements();
    futureElements.then((value) {
      setState(() {
        allElements = value;
        updateFilter();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
          appBar: AppBar(
              title: const Text('Elemente hinzufügen'),
            leading: null,
            automaticallyImplyLeading: false,
          ),
          body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10.0),
                Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                  const Text("D-Wert"),
                  for (int i = 0; i < filterDifficultyOptions.length; i++)
                    ChoiceChip(
                      labelPadding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 0.0),
                      showCheckmark: false,
                      label: Text(filterDifficultyOptions[i]),
                      selected:
                          filterDifficulty.contains(filterDifficultyOptions[i]),
                      onSelected: (bool selected) {
                        setState(() {
                          if (selected) {
                            filterDifficulty.add(filterDifficultyOptions[i]);
                          } else {
                            filterDifficulty.remove(filterDifficultyOptions[i]);
                          }
                          updateFilter();
                        });
                      },
                      selectedColor: Colors.blue,
                    )
                ]),
                Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,

                    children: [
                  const Text("Gruppe"),
                  for (int i = 0; i < filterGroupOptions.length; i++)
                    ChoiceChip(
                      labelPadding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 0.0),
                      showCheckmark: false,
                      label: Text(filterGroupOptions[i].toString()),
                      selected: filterGroup.contains(filterGroupOptions[i]),
                      onSelected: (bool selected) {
                        setState(() {
                          if (selected) {
                            filterGroup.add(filterGroupOptions[i]);
                          } else {
                            filterGroup.remove(filterGroupOptions[i]);
                          }
                          updateFilter();
                        });
                      },
                      selectedColor: Colors.blue,
                    )
                ]),
                ElementListCompact(elements: filteredElements, add: add),
                ButtonGroup(buttons: [
                  ButtonSpec(text: "Abbrechen", color: Colors.red, onPressed: cancel, icon: Icons.cancel),
                  ButtonSpec(text: "Speichern", color: Colors.blue, onPressed: save, icon: Icons.save),
                  ]
                ),
              ]
          )
      ),
    );
  }

  void updateFilter() {
    filteredElements = allElements.where((RoutineElement element) {
      bool matchesDifficulty = true;
      if (filterDifficulty.isNotEmpty) {
        matchesDifficulty = filterDifficulty.contains(element.difficulty);
      }

      bool matchesGroup = true;
      if (matchesDifficulty && filterGroup.isNotEmpty) {
        matchesDifficulty = filterGroup.contains(element.group);
      }

      return matchesDifficulty && matchesGroup;
    }).toList();
  }

  void add(RoutineElement element) {
    elementsToAdd.add(element);
  }

  void cancel() {
    List<RoutineElement> result = [];
    Navigator.pop(context, result);
  }

  void save() {
    Navigator.pop(context, elementsToAdd);
  }
}
