import '../classes/routine_element.dart';
import '../constants/element_list_pommel_horse.dart';
import '../constants/element_list_pommel_horse_extra.dart';
import '../constants/element_list_pommel_horse_national.dart';

/// Every pommel horse element the Code of Points defines, international,
/// national, and extra.
final List<RoutineElement> allPommelHorseElements = List.unmodifiable([
  ...ELEMENTS_POMMEL_HORSE,
  ...ELEMENTS_POMMEL_HORSE_NATIONAL,
  ...ELEMENTS_POMMEL_HORSE_EXTRA,
]);

List<RoutineElement> getAllElements() => allPommelHorseElements;

/// Looks up an element by [id], or `null` if no such element exists
/// (e.g. a saved routine references an element that was since renamed
/// or removed from the Code of Points).
RoutineElement? getRoutineElementById(String id) {
  for (final RoutineElement element in allPommelHorseElements) {
    if (element.id == id) {
      return element.copy();
    }
  }
  return null;
}
