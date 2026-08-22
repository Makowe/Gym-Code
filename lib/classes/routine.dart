import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gym_code/classes/apparatus.dart';
import 'package:gym_code/classes/routine_element.dart';
import 'package:gym_code/classes/routine_result.dart';
import 'package:gym_code/classes/rulebook.dart';
import 'package:gym_code/l10n/app_localizations.dart';
import 'package:gym_code/widgets/routine_card.dart';

import '../services/element_service.dart';

class Routine {
  int? id;
  String? name;
  List<RoutineElement> elements = [];
  RoutineResult? result;
  Apparatus apparatus;
  Rulebook rules;

  Routine(
      {this.id,
      this.name,
      required this.apparatus,
      this.rules = Rulebook.cop,
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

    List<RoutineElement> elements = elementsIds
        .map((id) => getRoutineElementById(id))
        .whereType<RoutineElement>()
        .toList();

    Routine routine = Routine(
        id: e['id'],
        name: e['name'],
        apparatus: Apparatus.values.byName(e['apparatus']),
        rules: Rulebook.values.byName(e['rules'] ?? Rulebook.cop.name),
        elements: elements);

    // A lightweight result carried over from the last save, so screens like
    // the routine list can show the D-score/penalty without evaluating
    // every routine. It lacks groups/numElements/hints, which are only
    // filled in once the routine is actually opened and fully evaluated.
    final num? dScore = e['d_score'];
    if (dScore != null) {
      routine.result = RoutineResult(dScore: dScore, penalty: e['penalty']);
    }

    return routine;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'apparatus': apparatus.name,
      'rules': rules.name,
      'elements': jsonEncode(elements.map((e) => e.id).toList()),
      'd_score': result?.dScore,
      'penalty': result?.penalty,
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

  Routine copy() {
    List<RoutineElement> copiedElements = [];
    for (var element in elements) {
      copiedElements.add(element.copy());
    }
    return Routine(
        id: id,
        name: name,
        apparatus: apparatus,
        rules: rules,
        elements: copiedElements);
  }
}
