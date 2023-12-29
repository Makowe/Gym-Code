import 'package:flutter/material.dart';
import 'package:gym_code/pages/view_routine.dart';
import 'package:gym_code/services/element_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initElementsDb();

  runApp(MaterialApp(
    initialRoute: '/',
    routes: {'/': (context) => const ViewRoutine()},
  ));
}
