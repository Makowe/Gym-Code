import '../classes/apparatus.dart';
import '../classes/routine_element.dart';
import '../constants/element_list_floor.dart';
import '../constants/element_list_floor_national.dart';
import '../constants/element_list_horizontal_bar.dart';
import '../constants/element_list_horizontal_bar_national.dart';
import '../constants/element_list_parallel_bars.dart';
import '../constants/element_list_parallel_bars_national.dart';
import '../constants/element_list_pommel_horse.dart';
import '../constants/element_list_pommel_horse_extra.dart';
import '../constants/element_list_pommel_horse_national.dart';
import '../constants/element_list_rings.dart';
import '../constants/element_list_rings_national.dart';
import '../constants/element_list_vault.dart';
import '../constants/element_list_vault_national.dart';

/// Every element the Code of Points defines, international and national
/// (and extra, where applicable), grouped by the apparatus they belong to.
final Map<Apparatus, List<RoutineElement>> elementsByApparatus = {
  Apparatus.floor: List.unmodifiable([
    ...ELEMENTS_FLOOR,
    ...ELEMENTS_FLOOR_NATIONAL,
  ]),
  Apparatus.pommelHorse: List.unmodifiable([
    ...ELEMENTS_POMMEL_HORSE,
    ...ELEMENTS_POMMEL_HORSE_NATIONAL,
    ...ELEMENTS_POMMEL_HORSE_EXTRA,
  ]),
  Apparatus.rings: List.unmodifiable([
    ...ELEMENTS_RINGS,
    ...ELEMENTS_RINGS_NATIONAL,
  ]),
  Apparatus.vault: List.unmodifiable([
    ...ELEMENTS_VAULT,
    ...ELEMENTS_VAULT_NATIONAL,
  ]),
  Apparatus.parallelBars: List.unmodifiable([
    ...ELEMENTS_PARALLEL_BARS,
    ...ELEMENTS_PARALLEL_BARS_NATIONAL,
  ]),
  Apparatus.horizontalBar: List.unmodifiable([
    ...ELEMENTS_HORIZONTAL_BAR,
    ...ELEMENTS_HORIZONTAL_BAR_NATIONAL,
  ]),
};

List<RoutineElement> getElementsForApparatus(Apparatus apparatus) =>
    elementsByApparatus[apparatus]!;

/// Looks up an element by [id], or `null` if no such element exists
/// (e.g. a saved routine references an element that was since renamed
/// or removed from the Code of Points).
RoutineElement? getRoutineElementById(String id) {
  for (final List<RoutineElement> elements in elementsByApparatus.values) {
    for (final RoutineElement element in elements) {
      if (element.id == id) {
        return element.copy();
      }
    }
  }
  return null;
}
