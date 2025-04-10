import 'dart:io';

class DemoInjectorService {
  static Future<bool> addGoogleMapExample(String projectPath) async {
    try {
      final libDir = Directory('$projectPath/lib');
      if (!await libDir.exists()) {
        print("lib/ folder not found in project.");
        return false;
      }

      final demoFile = File('${libDir.path}/google_map_page.dart');
      final mainFile = File('${libDir.path}/main.dart');

      await demoFile.writeAsString(_mapDemoCode);

      if (await mainFile.exists()) {
        await mainFile.writeAsString(_mainDartCode);
      } else {
        print("main.dart not found, skipping main screen override.");
      }

      return true;
    } catch (e) {
      print("Error injecting Google Map demo: $e");
      return false;
    }
  }

  static const String _mapDemoCode = '''
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPage extends StatelessWidget {
  const GoogleMapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const LatLng center = LatLng(23.8103, 90.4125); // Dhaka

    return Scaffold(
      appBar: AppBar(title: const Text('Google Map Example')),
      body: const GoogleMap(
        initialCameraPosition: CameraPosition(
          target: center,
          zoom: 14.0,
        ),
      ),
    );
  }
}
''';

  static const String _mainDartCode = '''
import 'package:flutter/material.dart';
import 'google_map_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GoogleMapPage(),
    );
  }
}
''';
}
