import 'package:flutter/material.dart';
import 'package:gym_code/classes/routine_element.dart';

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
    return Scaffold(
        appBar: AppBar(title: const Text('Elemente hinzufügen')),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10.0),
              const Text("D-Wert filtern"),
              Wrap(children: [
                for (int i = 0; i < filterDifficultyOptions.length; i++)
                  ChoiceChip(
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
              const Text("Gruppe filtern"),
              Wrap(children: [
                for (int i = 0; i < filterGroupOptions.length; i++)
                  ChoiceChip(
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
              FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 0.0),
                      child: FilledButton(
                          onPressed: () {
                            discard();
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.red[600])),
                          child: const Row(
                            children: [Icon(Icons.add), Text('Abbrechen')],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 0.0),
                      child: FilledButton(
                          onPressed: () {
                            save();
                          },
                          child: const Row(
                            children: [Icon(Icons.save), Text('Speichern')],
                          )),
                    ),
                  ],
                ),
              )
            ]));
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

  void discard() {
    Navigator.pop(context, []);
  }

  void save() {
    Navigator.pop(context, elementsToAdd);
  }
}
