import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gym_code/classes/routine_element.dart';
import 'package:gym_code/classes/routine_result.dart';
import 'package:gym_code/services/vocabulary_service.dart';
import 'package:gym_code/widgets/routine_card.dart';

import '../services/element_service.dart';

class Routine {
  static const int dismountGroup = 4;

  int? id;
  String? name;
  List<RoutineElement> elements = [];
  bool isValid = false;
  String? invalidText;
  RoutineResult? result;

  Routine({this.id, this.name, required List<RoutineElement> elements}) {
    addElements(elements);
  }

  Future<String> getDisplayName() async {
    if(name != null) { return name!; }
    else if(id != null) { return "${await Vocabulary.unnamedRoutine.get()} $id"; }
    else { return await Vocabulary.unnamedRoutine.get(); }
  }

  static Future<Routine> fromMap(Map<String, dynamic> e) async {
    List<dynamic> elementsIds = jsonDecode(e['elements']);
    List<Future<RoutineElement>> futureElements =
        elementsIds.map((e) => getRoutineElementById(e)).toList();
    List<RoutineElement> elements = await Future.wait(futureElements);

    return Routine(id: e['id'], name: e['name'], elements: elements);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
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

  RoutineElement? getDismount() {
    var dismountIndex =
        elements.indexWhere((element) => element.group == dismountGroup);
    if (dismountIndex == -1) {
      return null;
    }
    return elements[dismountIndex];
  }

  Routine copy() {
    List<RoutineElement> copiedElements = [];
    for (var element in elements) {
      copiedElements.add(element.copy());
    }
    return Routine(
        id: id,
        name: name,
        elements: copiedElements);
  }
}
