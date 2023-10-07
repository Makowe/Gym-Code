import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_code/widgets/routine_element_card.dart';

class RoutineElement {
  /// Map of language codes to element names,
  /// e.g., { 'en': 'handstand, 'de': 'Handstand' }
  Map<String, String> name;

  /// Assigned element difficulty according to Code of Points,
  /// e.g., 'NE', 'A', 'B'.
  String difficulty;

  /// Assigned element group according to Code of Points,
  /// allowed values: 1, 2, 3, 4
  int group;

  /// Unique ID of the element which is used to detect repetitions.
  String id;

  /// Bool that shows whether an element CAN be valued in a routine.
  /// Every element is valid by default and is set to invalid in
  /// the following cases:
  /// - The same element has already been shown.
  /// - The maximum number of a element type is exceeded
  ///   (e.g., too many Kovacs' on High bar)
  /// - A sequence of elements is not allowed (e.g., too many strength elements
  ///   in a row at the rings)
  bool isValid = true;

  /// Bool that shows whether an element IS valued in a routine.
  /// Every element is valued by default and can be set to not valued in
  /// the following cases:
  /// - The element is marked as invalid (see [RoutineElement.isValid].
  /// - The routine contains more elements than required and this element
  ///   does not count to the list of valued elements.
  bool isValued = true;

  RoutineElement(
      {required this.name,
      required this.difficulty,
      required this.group,
      required this.id});

  Widget toWidget(
      {required int index, required bool allowEdit, Function? delete}) {
    return RoutineElementCard(
        element: this,
        index: index,
        allowEdit: allowEdit,
        delete: delete,
        key: Key('$index'));
  }

  RoutineElement copy() {
    return RoutineElement(
        name: name, difficulty: difficulty, group: group, id: id);
  }
}
