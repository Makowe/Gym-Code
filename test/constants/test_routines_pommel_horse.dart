import 'package:gym_code/classes/apparatus.dart';
import 'package:gym_code/classes/routine.dart';
import 'package:gym_code/constants/element_list_pommel_horse.dart';
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
