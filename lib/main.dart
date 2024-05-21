import 'package:flutter/material.dart';
import 'package:gym_code/pages/view_all_routines.dart';
import 'package:gym_code/services/element_service.dart';
import 'package:gym_code/services/routine_service.dart';
import 'package:gym_code/services/settings_service.dart';
import 'package:gym_code/services/vocabulary_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initElementsDb();
  await initRoutinesDb();
  await initSettingsDb();
  await initVocabularyDb();

  runApp(MaterialApp(
    initialRoute: '/',
    routes: {'/': (context) => const ViewAllRoutines()},
  ));
}
