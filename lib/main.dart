import 'package:flutter/material.dart';
import 'package:gym_code/pages/edit_routine.dart';
import 'package:gym_code/pages/view_routine.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => ViewRoutine()
    },
  ));
}

