import 'package:gym_code/classes/routine_element.dart';
import 'package:gym_code/classes/routine_result.dart';

class Routine {
  static const int dismountGroup = 4;

  List<RoutineElement> elements;
  bool isValid = false;
  String? invalidText;
  RoutineResult? result;

  Routine({required this.elements});

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
    return Routine(elements: copiedElements);
  }
}
