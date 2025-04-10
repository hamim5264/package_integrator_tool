import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/project_picker_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Package Integrator Tool',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const ProjectPickerScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
