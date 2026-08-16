import 'package:gym_code/classes/apparatus.dart';
import 'package:gym_code/classes/routine.dart';
import 'package:gym_code/classes/routine_element.dart';
import 'package:gym_code/constants/element_list_pommel_horse.dart';
import 'package:gym_code/constants/element_list_pommel_horse_extra.dart';
import 'package:gym_code/constants/element_list_pommel_horse_national.dart';

// VALID ROUTINES

Routine shortRoutineNoDismount = Routine(
    apparatus: Apparatus.pommelHorse, elements: [p_1_1, p_1_7, p_1_13, p_2_1]);

Routine shortRoutineWithDismount = Routine(
    apparatus: Apparatus.pommelHorse,
    elements: [p_1_1, p_1_7, p_1_13, p_2_1, p_4_1]);

Routine mediumRoutineNoDismount = Routine(
    apparatus: Apparatus.pommelHorse,
    elements: [p_1_1, p_1_7, p_1_8, p_1_13, p_2_1, p_2_92, p_3_1]);

Routine mediumRoutineWithDismount = Routine(
    apparatus: Apparatus.pommelHorse,
    elements: [p_1_1, p_1_7, p_1_8, p_1_13, p_2_1, p_2_92, p_3_1, p_4_1]);

Routine longRoutineNoDismount = Routine(
    apparatus: Apparatus.pommelHorse,
    elements: [p_1_1, p_1_3, p_1_7, p_1_8, p_1_13, p_2_1, p_2_92, p_3_1]);

Routine longRoutineWithDismount = Routine(
    apparatus: Apparatus.pommelHorse,
    elements: [
      p_1_1,
      p_1_3,
      p_1_7,
      p_1_8,
      p_1_13,
      p_2_1,
      p_2_92,
      p_3_1,
      p_4_1
    ]);

Routine longRoutineOtherOrder = Routine(
    apparatus: Apparatus.pommelHorse,
    elements: [
      p_1_1,
      p_1_3,
      p_1_7,
      p_1_13,
      p_2_1,
      p_2_92,
      p_3_1,
      p_1_8,
      p_4_1
    ]);

// REPETITIONS

Routine shortRoutineRepetition =
    Routine(apparatus: Apparatus.pommelHorse, elements: [p_2_92, p_2_92]);

Routine multipleRepetitions = Routine(
    apparatus: Apparatus.pommelHorse,
    elements: [p_1_1, p_2_92, p_1_1, p_2_92, p_1_1, p_2_1]);

// INVALID ROUTINES

Routine emptyRoutine = Routine(apparatus: Apparatus.pommelHorse, elements: []);

Routine routineDismountInMiddle =
    Routine(apparatus: Apparatus.pommelHorse, elements: [p_1_1, p_4_1, p_1_7]);

Routine routineMultipleDismounts =
    Routine(apparatus: Apparatus.pommelHorse, elements: [p_1_1, p_4_1, p_n_22]);

// POMMEL HORSE SPECIFIC RULES

// p_x_2 (E) has higher difficulty than p_x_1 (D), so p_x_1 should be
// invalidated.
Routine routineTwoFlops = Routine(
    apparatus: Apparatus.pommelHorse, elements: [p_x_1, p_x_2, p_1_1, p_4_1]);

// pXFourWithTiedDifficulty has the same difficulty as p_x_3 (D). The first
// of the two elements in the routine (p_x_3) should stay valid.
RoutineElement pXFourWithTiedDifficulty = RoutineElement(
    name: {'en': 'test combination with tied difficulty'},
    difficulty: p_x_3.difficulty,
    group: p_x_3.group,
    id: p_x_4.id);

Routine routineTwoCombinationsSameDifficulty = Routine(
    apparatus: Apparatus.pommelHorse,
    elements: [p_x_3, pXFourWithTiedDifficulty, p_1_1, p_4_1]);

// p_n_1 directly follows its required predecessor p_1_1 and should stay
// valid.
Routine routineNationalElementWithPredecessor = Routine(
    apparatus: Apparatus.pommelHorse, elements: [p_1_1, p_n_1, p_1_13, p_4_1]);

// p_n_1 does not directly follow p_1_1 (p_1_13 is in between) and should be
// invalidated.
Routine routineNationalElementWithoutPredecessor = Routine(
    apparatus: Apparatus.pommelHorse, elements: [p_1_1, p_1_13, p_n_1, p_4_1]);

// p_n_9 accepts either p_2_1 or p_n_10 as predecessor.
Routine routineNationalElementWithAlternativePredecessor = Routine(
    apparatus: Apparatus.pommelHorse,
    elements: [p_1_1, p_n_10, p_n_9, p_4_1]);
