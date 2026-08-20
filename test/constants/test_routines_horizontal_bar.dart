import 'package:gym_code/classes/apparatus.dart';
import 'package:gym_code/classes/routine.dart';
import 'package:gym_code/constants/element_list_horizontal_bar.dart';

Routine shortRoutineNoDismount = Routine(
    apparatus: Apparatus.horizontalBar,
    elements: [hb_1_1, hb_1_2, hb_2_2, hb_3_1]);

Routine mediumRoutineWithDismount = Routine(
    apparatus: Apparatus.horizontalBar,
    elements: [hb_1_1, hb_1_2, hb_2_2, hb_3_1, hb_4_1]);

Routine routineRepetition =
    Routine(apparatus: Apparatus.horizontalBar, elements: [hb_2_2, hb_2_2]);

Routine routineDismountInMiddle = Routine(
    apparatus: Apparatus.horizontalBar, elements: [hb_1_1, hb_4_1, hb_1_2]);
