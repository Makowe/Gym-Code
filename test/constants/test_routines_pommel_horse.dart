import 'package:gym_code/classes/routine.dart';
import 'package:gym_code/constants/element_list_pommel_horse.dart';

// VALID ROUTINES

Routine shortRoutineNoDismount =
    Routine(elements: [p_1_1, p_1_7, p_1_13, p_2_1]);

Routine shortRoutineWithDismount =
    Routine(elements: [p_1_1, p_1_7, p_1_13, p_2_1, p_4_1]);

Routine mediumRoutineNoDismount =
    Routine(elements: [p_1_1, p_1_7, p_1_8, p_1_13, p_2_1, p_2_92, p_3_1]);

Routine mediumRoutineWithDismount = Routine(
    elements: [p_1_1, p_1_7, p_1_8, p_1_13, p_2_1, p_2_92, p_3_1, p_4_1]);

Routine longRoutineNoDismount = Routine(
    elements: [p_1_1, p_1_3, p_1_7, p_1_8, p_1_13, p_2_1, p_2_92, p_3_1]);

Routine longRoutineWithDismount = Routine(elements: [
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

Routine longRoutineOtherOrder = Routine(elements: [
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

Routine shortRoutineRepetition = Routine(elements: [p_2_92, p_2_92]);

Routine multipleRepetitions =
    Routine(elements: [p_1_1, p_2_92, p_1_1, p_2_92, p_1_1, p_2_1]);

// INVALID ROUTINES

Routine emptyRoutine = Routine(elements: []);

Routine routineDismountInMiddle = Routine(elements: [p_1_1, p_4_1, p_1_7]);

Routine routineMultipleDismounts = Routine(elements: [p_1_1, p_4_1, p_n_22]);
