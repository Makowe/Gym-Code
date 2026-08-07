import '../classes/routine_element.dart';
import '../constants/element_list_pommel_horse.dart';
import '../constants/element_list_pommel_horse_national.dart';

/// Every pommel horse element the Code of Points defines, international and
/// national. This is compiled-in, static data -- it never changes at
/// runtime, so it lives in memory rather than round-tripping through a
/// database.
final List<RoutineElement> allPommelHorseElements = List.unmodifiable([
  ...ELEMENTS_POMMEL_HORSE,
  ...ELEMENTS_POMMEL_HORSE_NATIONAL,
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
