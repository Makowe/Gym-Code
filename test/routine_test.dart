import 'package:test/test.dart';

import 'constants/test_routines_pommel_horse.dart';

void main() {
  group('Basic Routine Functions', () {
    test('Count valid elements', () {
      for (var element in shortRoutineNoDismount.elements) {
        element.isValid = true;
      }
      expect(shortRoutineNoDismount.getNumValidElements(), 4);
      shortRoutineNoDismount.elements[1].isValid = false;
      expect(shortRoutineNoDismount.getNumValidElements(), 3);
    });

    test('Count valued elements', () {
      for (var element in shortRoutineNoDismount.elements) {
        element.isValued = true;
      }
      expect(shortRoutineNoDismount.getNumValuedElements(), 4);
      shortRoutineNoDismount.elements[1].isValued = false;
      expect(shortRoutineNoDismount.getNumValuedElements(), 3);
    });

    test('Count valued elements beside dismount', () {
      // expect same result as in test above because there is no dismount
      for (var element in shortRoutineNoDismount.elements) {
        element.isValued = true;
      }

      expect(shortRoutineNoDismount.getNumValuedElementsBesideDismount(), 4);
      shortRoutineNoDismount.elements[1].isValued = false;
      expect(shortRoutineNoDismount.getNumValuedElementsBesideDismount(), 3);

      // expect different result because new routine contains dismount
      for (var element in shortRoutineWithDismount.elements) {
        element.isValued = true;
      }

      expect(shortRoutineWithDismount.getNumValuedElementsBesideDismount(), 4);
      shortRoutineWithDismount.elements[1].isValued = false;
      expect(shortRoutineWithDismount.getNumValuedElementsBesideDismount(), 3);
      shortRoutineWithDismount.elements[4].isValued = false;
      expect(shortRoutineWithDismount.getNumValuedElementsBesideDismount(), 3);
    });

    test('Get Dismount', () {
      expect(shortRoutineNoDismount.getDismount(), null);
      expect(shortRoutineWithDismount.getDismount(),
          shortRoutineWithDismount.elements[4]);
    });

    test('Copy', () {
      // Constant Values should be the same in both routines
      var basicRoutineCopy = shortRoutineNoDismount.copy();
      for (int i = 0; i < shortRoutineNoDismount.elements.length; i++) {
        expect(basicRoutineCopy.elements[i].id,
            shortRoutineNoDismount.elements[i].id);
        expect(basicRoutineCopy.elements[i].name,
            shortRoutineNoDismount.elements[i].name);
        expect(basicRoutineCopy.elements[i].difficulty,
            shortRoutineNoDismount.elements[i].difficulty);
        expect(basicRoutineCopy.elements[i].group,
            shortRoutineNoDismount.elements[i].group);
      }

      // Modifying IsValid or IsValued in one element should not modify the copy
      for (var element in shortRoutineNoDismount.elements) {
        element.isValued = true;
        element.isValued = true;
      }

      for (var element in basicRoutineCopy.elements) {
        element.isValued = true;
        element.isValued = true;
      }

      basicRoutineCopy.elements[0].isValid = false;
      basicRoutineCopy.elements[1].isValued = false;

      expect(basicRoutineCopy.elements[0].isValid, false);
      expect(shortRoutineNoDismount.elements[0].isValid, true);
      expect(basicRoutineCopy.elements[1].isValued, false);
      expect(shortRoutineNoDismount.elements[1].isValued, true);
    });
  });
}
