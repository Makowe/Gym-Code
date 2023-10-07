import 'package:gym_code/classes/routine.dart';
import 'package:gym_code/constants/element_list_pommel_horse.dart';
import 'package:test/test.dart';

Routine basicRoutineNoDismount = Routine(
    elements: [
      p_1_1,
      p_1_7,
      p_1_13,
      p_2_1
    ]
);

Routine basicRoutineWithDismount = Routine(
    elements: [
      p_1_1,
      p_1_7,
      p_1_13,
      p_2_1,
      p_4_1
    ]
);


void main() {
  group('Basic Routine Functions', () {
    test('Count valid elements', () {
      basicRoutineNoDismount.elements.forEach((element) {
        element.isValid = true;
      });
      expect(basicRoutineNoDismount.getNumValidElements(), 4);
      basicRoutineNoDismount.elements[1].isValid = false;
      expect(basicRoutineNoDismount.getNumValidElements(), 3);
    });

    test('Count valued elements', () {
      basicRoutineNoDismount.elements.forEach((element) {
        element.isValued = true;
      });
      expect(basicRoutineNoDismount.getNumValuedElements(), 4);
      basicRoutineNoDismount.elements[1].isValued = false;
      expect(basicRoutineNoDismount.getNumValuedElements(), 3);
    });

    test('Count valued elements beside dismount', () {
      // expect same result as in test above because there is no dismount
      basicRoutineNoDismount.elements.forEach((element) {
        element.isValued = true;
      });

      expect(basicRoutineNoDismount.getNumValuedElementsBesideDismount(), 4);
      basicRoutineNoDismount.elements[1].isValued = false;
      expect(basicRoutineNoDismount.getNumValuedElementsBesideDismount(), 3);

      // expect different result because new routine contains dismount
      basicRoutineWithDismount.elements.forEach((element) {
        element.isValued = true;
      });

      expect(basicRoutineWithDismount.getNumValuedElementsBesideDismount(), 4);
      basicRoutineWithDismount.elements[1].isValued = false;
      expect(basicRoutineWithDismount.getNumValuedElementsBesideDismount(), 3);
      basicRoutineWithDismount.elements[4].isValued = false;
      expect(basicRoutineWithDismount.getNumValuedElementsBesideDismount(), 3);
    });

    test('Get Dismount', () {
      expect(basicRoutineNoDismount.getDismount(), null);
      expect(
          basicRoutineWithDismount.getDismount(),
          basicRoutineWithDismount.elements[4]);
    });

    test('Copy', () {
      // Constant Values should be the same in both routines
      var basicRoutineCopy = basicRoutineWithDismount.copy();
      for(int i = 0; i < basicRoutineWithDismount.elements.length; i++) {
        expect(
            basicRoutineCopy.elements[i].id,
            basicRoutineWithDismount.elements[i].id);
        expect(
            basicRoutineCopy.elements[i].name,
            basicRoutineWithDismount.elements[i].name);
        expect(
            basicRoutineCopy.elements[i].difficulty,
            basicRoutineWithDismount.elements[i].difficulty);
        expect(
            basicRoutineCopy.elements[i].group,
            basicRoutineWithDismount.elements[i].group);
      }

      // Modifying IsValid or IsValued in one element should not modify the copy
      basicRoutineWithDismount.elements.forEach((element) {
        element.isValued = true;
        element.isValued = true;
      });

      basicRoutineCopy.elements.forEach((element) {
        element.isValued = true;
        element.isValued = true;
      });

      basicRoutineCopy.elements[0].isValid = false;
      basicRoutineCopy.elements[1].isValued = false;

      expect(basicRoutineCopy.elements[0].isValid, false);
      expect(basicRoutineWithDismount.elements[0].isValid, true);
      expect(basicRoutineCopy.elements[1].isValued, false);
      expect(basicRoutineWithDismount.elements[1].isValued, true);
    });

  });
}