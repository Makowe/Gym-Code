import 'package:flutter/material.dart';
import 'package:gym_code/classes/routine_element.dart';
import 'package:gym_code/l10n/app_localizations.dart';
import 'package:gym_code/widgets/button_group.dart';

import '../classes/apparatus.dart';
import '../services/element_service.dart';
import '../widgets/element_list_compact.dart';

class AddElements extends StatefulWidget {
  const AddElements({super.key, required this.apparatus});

  final Apparatus apparatus;

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

  static const Map<String, List<String>> difficultyFilterValues = {
    'F+': ['F', 'G', 'H', 'I', 'J'],
  };

  /* If filter is "F+", a list of multiple values is returned. In all other cases,
  return the filter value itself. */
  static List<String> _valuesForDifficultyFilter(String filter) =>
      difficultyFilterValues[filter] ?? [filter];

  static const List<int> filterGroupOptions = [1, 2, 3, 4];

  Set<String> filterDifficulty = {};
  Set<num> filterGroup = {};

  late List<RoutineElement> allElements;
  List<RoutineElement> filteredElements = [];
  List<RoutineElement> elementsToAdd = [];

  @override
  void initState() {
    super.initState();
    allElements = getElementsForApparatus(widget.apparatus);
    updateFilter();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return PopScope(
      canPop: false,
      child: Scaffold(
          appBar: AppBar(
            title: Text(l10n.addElements),
            leading: null,
            automaticallyImplyLeading: false,
          ),
          body: SafeArea(
            top: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10.0),
                Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(l10n.dScore),
                      for (int i = 0; i < filterDifficultyOptions.length; i++)
                        ChoiceChip(
                          labelPadding: const EdgeInsets.symmetric(
                              horizontal: 2.0, vertical: 0.0),
                          showCheckmark: false,
                          label: Text(filterDifficultyOptions[i]),
                          selected: filterDifficulty
                              .contains(filterDifficultyOptions[i]),
                          onSelected: (bool selected) {
                            setState(() {
                              if (selected) {
                                filterDifficulty
                                    .add(filterDifficultyOptions[i]);
                              } else {
                                filterDifficulty
                                    .remove(filterDifficultyOptions[i]);
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
                      Text(l10n.group),
                      for (int i = 0; i < filterGroupOptions.length; i++)
                        ChoiceChip(
                          labelPadding: const EdgeInsets.symmetric(
                              horizontal: 2.0, vertical: 0.0),
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
                ButtonGroup([
                  ButtonSpec(
                      label: l10n.cancel,
                      color: colorScheme.secondaryContainer,
                      textColor: colorScheme.onSecondaryContainer,
                      onPressed: cancel,
                      icon: Icons.cancel),
                  ButtonSpec(
                      label: l10n.save,
                      color: colorScheme.primary,
                      textColor: colorScheme.onPrimary,
                      onPressed: save,
                      icon: Icons.save),
                ]),
              ],
            ),
          )),
    );
  }

  void updateFilter() {
    filteredElements = allElements.where((RoutineElement element) {
      bool matchesDifficulty = true;
      if (filterDifficulty.isNotEmpty) {
        matchesDifficulty = filterDifficulty.any((filter) =>
            _valuesForDifficultyFilter(filter).contains(element.difficulty));
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
