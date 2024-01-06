import 'package:flutter/material.dart';
import 'package:gym_code/pages/view_all_routines.dart';
import 'package:gym_code/services/element_service.dart';
import 'package:gym_code/services/routine_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initElementsDb();
  await initRoutinesDb();

  runApp(MaterialApp(
    initialRoute: '/',
    routes: {'/': (context) => const ViewAllRoutines()},
  ));
}
