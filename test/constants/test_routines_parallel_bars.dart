import 'package:gym_code/classes/apparatus.dart';
import 'package:gym_code/classes/routine.dart';
import 'package:gym_code/constants/element_list_parallel_bars.dart';

Routine shortRoutineNoDismount = Routine(
    apparatus: Apparatus.parallelBars,
    elements: [pb_1_1, pb_1_2, pb_2_1, pb_3_4]);

Routine mediumRoutineWithDismount = Routine(
    apparatus: Apparatus.parallelBars,
    elements: [pb_1_1, pb_1_2, pb_2_1, pb_3_4, pb_4_1]);

Routine routineRepetition =
    Routine(apparatus: Apparatus.parallelBars, elements: [pb_2_1, pb_2_1]);

Routine routineDismountInMiddle = Routine(
    apparatus: Apparatus.parallelBars, elements: [pb_1_1, pb_4_1, pb_1_2]);
