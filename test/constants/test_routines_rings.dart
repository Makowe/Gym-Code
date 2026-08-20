import 'package:gym_code/classes/apparatus.dart';
import 'package:gym_code/classes/routine.dart';
import 'package:gym_code/constants/element_list_rings.dart';

Routine shortRoutineNoDismount = Routine(
    apparatus: Apparatus.rings, elements: [r_1_1, r_1_7, r_2_1, r_3_2]);

Routine mediumRoutineWithDismount = Routine(
    apparatus: Apparatus.rings,
    elements: [r_1_1, r_1_7, r_2_1, r_3_2, r_4_1]);

Routine routineRepetition =
    Routine(apparatus: Apparatus.rings, elements: [r_2_1, r_2_1]);

Routine routineDismountInMiddle =
    Routine(apparatus: Apparatus.rings, elements: [r_1_1, r_4_1, r_1_7]);
