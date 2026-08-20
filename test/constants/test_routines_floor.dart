import 'package:gym_code/classes/apparatus.dart';
import 'package:gym_code/classes/routine.dart';
import 'package:gym_code/constants/element_list_floor.dart';
import 'package:gym_code/constants/element_list_floor_national.dart';

// FLOOR SPECIFIC DISMOUNT RULES

// f_3_1 is not a "no dismount" element, so it is the dismount even though
// it is group 3, not group 4.
Routine routineDismountInGroupThree =
    Routine(apparatus: Apparatus.floor, elements: [f_1_1, f_2_1, f_3_1]);

// The last element belongs to group 1, so the routine has no dismount.
Routine routineLastElementGroupOne =
    Routine(apparatus: Apparatus.floor, elements: [f_2_1, f_3_1, f_1_1]);

// f_2_7 is a "no dismount" element even though it is group 2.
Routine routineLastElementIsNoDismountId =
    Routine(apparatus: Apparatus.floor, elements: [f_1_1, f_3_1, f_2_7]);

// An earlier element (f_3_1) shares its id with the dismount (also f_3_1 at
// the end); the earlier one should be invalidated as a repetition while the
// dismount itself stays valid.
Routine routineEarlierElementRepeatsDismount =
    Routine(apparatus: Apparatus.floor, elements: [f_1_1, f_3_1, f_2_1, f_3_1]);

Routine emptyRoutine = Routine(apparatus: Apparatus.floor, elements: []);

// GROUP 4 SCORING

// Contains a valid, non-dismount group 4 element (f_4_2); group 4 should
// score the presence bonus even though the dismount (f_3_1) is group 3.
Routine routineWithGroupFourNonDismount =
    Routine(apparatus: Apparatus.floor, elements: [f_1_1, f_2_1, f_4_2, f_3_1]);

// INHERITED BEHAVIOR

Routine mediumRoutineWithDismount = Routine(
    apparatus: Apparatus.floor,
    elements: [f_1_1, f_1_7, f_1_25, f_2_1, f_n_1, f_3_1]);
