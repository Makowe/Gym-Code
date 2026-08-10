import 'package:gym_code/classes/routine_element.dart';
import 'package:gym_code/services/element_service.dart';
import 'package:test/test.dart';

void main() {
  final List<RoutineElement> allElements =
      elementsByApparatus.values.expand((elements) => elements).toList();

  group('Element roster', () {
    test('every element has a unique id', () {
      final List<String> ids =
          allElements.map((element) => element.id).toList();

      expect(ids.toSet().length, ids.length,
          reason: 'duplicate element ids would silently drop elements '
              'from lookups and break routines that reference them');
    });

    test('every element resolves by id and returns an independent copy', () {
      for (final element in allElements) {
        final found = getRoutineElementById(element.id);
        expect(found, isNotNull, reason: 'id ${element.id} did not resolve');
        expect(found, isNot(same(element)),
            reason: 'lookup must not hand out the shared canonical instance');
      }
    });

    test('an unknown id resolves to null instead of throwing', () {
      expect(getRoutineElementById('does-not-exist'), isNull);
    });
  });

  group('getElementsForApparatus', () {
    test('returns only elements for the requested apparatus', () {
      for (final apparatus in elementsByApparatus.keys) {
        expect(getElementsForApparatus(apparatus),
            same(elementsByApparatus[apparatus]));
      }
    });
  });
}
