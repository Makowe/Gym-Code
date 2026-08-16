import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gym_code/classes/apparatus.dart';
import 'package:gym_code/classes/routine_element.dart';
import 'package:gym_code/classes/routine_result.dart';
import 'package:gym_code/l10n/app_localizations.dart';
import 'package:gym_code/widgets/routine_card.dart';

import '../services/element_service.dart';

class Routine {
  static const int dismountGroup = 4;

  int? id;
  String? name;
  List<RoutineElement> elements = [];
  RoutineResult? result;
  Apparatus apparatus;

  Routine(
      {this.id,
      this.name,
      required this.apparatus,
      required List<RoutineElement> elements}) {
    addElements(elements);
  }

  String getDisplayName(AppLocalizations l10n) {
    if (name != null) {
      return name!;
    } else if (id != null) {
      return '${l10n.unnamedRoutine} $id';
    } else {
      return l10n.unnamedRoutine;
    }
  }

  static Future<Routine> fromMap(Map<String, dynamic> e) async {
    List<dynamic> elementsIds = jsonDecode(e['elements']);
    // Elements no longer present in the Code of Points (id renamed/removed
    // since this routine was saved) are dropped rather than crashing the
    // whole routine.
    List<RoutineElement> elements = elementsIds
        .map((id) => getRoutineElementById(id))
        .whereType<RoutineElement>()
        .toList();

    return Routine(
        id: e['id'],
        name: e['name'],
        apparatus: Apparatus.values.byName(e['apparatus']),
        elements: elements);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'apparatus': apparatus.name,
      'elements': jsonEncode(elements.map((e) => e.id).toList())
    };
  }

  Widget toWidget(int index, Function view) {
    return RoutineCard(routine: this, index: index, view: view);
  }

  void addElements(List<RoutineElement> elements) {
    /* Instead of assigning the list directly to the Routine instance,
     * every element in the list is copied and added to the routine.
     * This prevents that the same element instance occurs multiple time
     * in a routine.
     */
    for (var element in elements) {
      addElement(element);
    }
  }

  void addElement(RoutineElement element) {
    elements.add(element.copy());
  }

  int getNumValidElements() {
    int numValidElements = 0;
    for (var element in elements) {
      if (element.isValid) {
        numValidElements += 1;
      }
    }
    return numValidElements;
  }

  int getNumValuedElements() {
    int numValuedElements = 0;
    for (var element in elements) {
      if (element.isValued) {
        numValuedElements += 1;
      }
    }
    return numValuedElements;
  }

  int getNumValuedElementsBesideDismount() {
    int numValuedElements = 0;
    for (var element in elements) {
      if (element.isValued && element.group != dismountGroup) {
        numValuedElements += 1;
      }
    }
    return numValuedElements;
  }

  /// The routine's dismount, i.e. its last element if that element has
  /// group number [dismountGroup], or `null` otherwise.
  /// *Comment*: Only the routine's actual last element can ever be "at the
  /// end", so any other, earlier group-4 element is invalid (see
  /// `InvalidElementReason.dismountNotAtEnd`) and not the dismount.
  RoutineElement? getDismount() {
    if (elements.isEmpty || elements.last.group != dismountGroup) {
      return null;
    }
    return elements.last;
  }

  Routine copy() {
    List<RoutineElement> copiedElements = [];
    for (var element in elements) {
      copiedElements.add(element.copy());
    }
    return Routine(
        id: id, name: name, apparatus: apparatus, elements: copiedElements);
  }
}
