import 'package:flutter/material.dart';
import 'package:gym_code/classes/routine_element.dart';
import 'package:gym_code/l10n/app_localizations.dart';
import 'package:gym_code/widgets/button_group.dart';

import '../classes/apparatus.dart';
import '../classes/rulebook.dart';
import '../services/element_service.dart';
import '../widgets/element_list_compact.dart';

class AddElements extends StatefulWidget {
  const AddElements(
      {super.key, required this.apparatus, required this.rulebook});

  final Apparatus apparatus;

  /// The routine's rulebook. Code of Points routines cannot score National
  /// Elements (difficulty "NE"), so those are excluded both from the
  /// results and from the difficulty filter. LK routines instead only
  /// offer a reduced difficulty filter (NE, A, B, C, D+).
  final Rulebook rulebook;

  @override
  State<AddElements> createState() => _AddElementsState();
}

class _AddElementsState extends State<AddElements> {
  bool get _isCop => widget.rulebook == Rulebook.cop;

  late final Map<String, List<String>> difficultyFilterValues = _isCop
      ? const {
          'F+': ['F', 'G', 'H', 'I', 'J'],
        }
      : const {
          'D+': ['D', 'E', 'F', 'G', 'H', 'I', 'J'],
        };

  /* If filter is "F+"/"D+", a list of multiple values is returned. In all
  other cases, return the filter value itself. */
  List<String> _valuesForDifficultyFilter(String filter) =>
      difficultyFilterValues[filter] ?? [filter];

  static const List<int> filterGroupOptions = [1, 2, 3, 4];

  late final List<String> filterDifficultyOptions = _isCop
      ? const ['A', 'B', 'C', 'D', 'E', 'F+']
      : const ['NE', 'A', 'B', 'C', 'D+'];

  Set<String> filterDifficulty = {};
  Set<int> filterGroup = {};

  static ButtonStyle _filterSegmentStyle(ColorScheme colorScheme) =>
      SegmentedButton.styleFrom(
        selectedBackgroundColor: colorScheme.tertiary,
        selectedForegroundColor: colorScheme.onTertiary,
        visualDensity: VisualDensity.compact,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: const Size(0.0, 0.0),
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      );

  final TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  late List<RoutineElement> allElements;
  List<RoutineElement> filteredElements = [];
  List<RoutineElement> elementsToAdd = [];

  @override
  void initState() {
    super.initState();
    allElements = getElementsForApparatus(widget.apparatus)
        .where((element) => !_isCop || element.difficulty != 'NE')
        .toList();
    updateFilter();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                  child: SearchBar(
                    controller: searchController,
                    hintText: l10n.searchElements,
                    elevation: const WidgetStatePropertyAll(0.0),
                    shadowColor:
                        const WidgetStatePropertyAll(Colors.transparent),
                    constraints:
                        const BoxConstraints(minHeight: 40.0, maxHeight: 40.0),
                    leading: const Icon(Icons.search, size: 20.0),
                    trailing: [
                      if (searchQuery.isNotEmpty)
                        IconButton(
                          icon: const Icon(Icons.clear, size: 20.0),
                          visualDensity: VisualDensity.compact,
                          onPressed: () {
                            setState(() {
                              searchController.clear();
                              searchQuery = '';
                              updateFilter();
                            });
                          },
                        ),
                    ],
                    onChanged: (String value) {
                      setState(() {
                        searchQuery = value;
                        updateFilter();
                      });
                    },
                  ),
                ),
                ElementListCompact(elements: filteredElements, add: add),
                Container(
                  margin: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.filter,
                          style: const TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          Text(l10n.dScore,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SegmentedButton<String>(
                                multiSelectionEnabled: true,
                                emptySelectionAllowed: true,
                                showSelectedIcon: false,
                                style: _filterSegmentStyle(colorScheme),
                                segments: [
                                  for (final option in filterDifficultyOptions)
                                    ButtonSegment(
                                        value: option, label: Text(option)),
                                ],
                                selected: filterDifficulty,
                                onSelectionChanged: (Set<String> selected) {
                                  setState(() {
                                    filterDifficulty = selected;
                                    updateFilter();
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          Text(l10n.group,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SegmentedButton<int>(
                                multiSelectionEnabled: true,
                                emptySelectionAllowed: true,
                                showSelectedIcon: false,
                                style: _filterSegmentStyle(colorScheme),
                                segments: [
                                  for (final option in filterGroupOptions)
                                    ButtonSegment(
                                        value: option, label: Text('$option')),
                                ],
                                selected: filterGroup,
                                onSelectionChanged: (Set<int> selected) {
                                  setState(() {
                                    filterGroup = selected;
                                    updateFilter();
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ButtonGroup([
                  ButtonSpec(
                      type: ButtonType.textSecondary,
                      label: l10n.cancel,
                      onPressed: cancel,
                      icon: Icons.cancel),
                  ButtonSpec(
                      label: l10n.save, onPressed: save, icon: Icons.save),
                ]),
              ],
            ),
          )),
    );
  }

  void updateFilter() {
    filteredElements = allElements.where((RoutineElement element) {
      bool matchesDifficulty = filterDifficulty.isEmpty ||
          filterDifficulty.any((filter) =>
              _valuesForDifficultyFilter(filter).contains(element.difficulty));

      bool matchesGroup =
          filterGroup.isEmpty || filterGroup.contains(element.group);

      bool matchesSearch = searchQuery.isEmpty ||
          element.name.values.any(
              (name) => name.toLowerCase().contains(searchQuery.toLowerCase()));

      return matchesDifficulty && matchesGroup && matchesSearch;
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
