import 'dart:io';
import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

class PubspecService {
  static Future<bool> addGoogleMapsPackage(String projectPath) async {
    try {
      final pubspecFile = File('$projectPath/pubspec.yaml');

      if (!await pubspecFile.exists()) {
        print("pubspec.yaml not found at $projectPath");
        return false;
      }

      print("pubspec.yaml found");

      final content = await pubspecFile.readAsString();
      print("Original content loaded");

      final doc = loadYaml(content);
      print("YAML parsed");

      final dependencies = doc['dependencies'] ?? {};
      print("Dependencies found: $dependencies");

      final editor = YamlEditor(content);

      if (dependencies.containsKey('google_maps_flutter')) {
        print("google_maps_flutter already exists.");
        return true;
      }

      print("Adding google_maps_flutter");
      editor.update(['dependencies', 'google_maps_flutter'], '^2.5.0');

      await pubspecFile.writeAsString(editor.toString());
      print("Package written to pubspec.yaml");

      return true;
    } catch (e, stacktrace) {
      print("Error in addGoogleMapsPackage: $e");
      print(stacktrace);
      return false;
    }
  }

  static Future<bool> runFlutterPubGet(String projectPath) async {
    try {
      final result = await Process.run('flutter', [
        'pub',
        'get',
      ], workingDirectory: projectPath);

      print("STDOUT:\n${result.stdout}");
      print("STDERR:\n${result.stderr}");

      return result.exitCode == 0;
    } catch (e) {
      print("Error in flutter pub get: $e");
      return false;
    }
  }
}
