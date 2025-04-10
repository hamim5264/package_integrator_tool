import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import '../providers/project_provider.dart';

class ProjectPickerScreen extends ConsumerWidget {
  const ProjectPickerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(projectStatusProvider);
    final packageStatus = ref.watch(packageAddStatusProvider);
    final installPackage = ref.read(packageInstallerProvider);

    final apiKey = ref.watch(apiKeyProvider);
    final apiKeyStatus = ref.watch(apiKeyStatusProvider);
    final setApiKey = ref.read(apiKeyProvider.notifier);
    final handleApiKey = ref.read(apiKeyManagerProvider);

    final demoStatus = ref.watch(demoStatusProvider);
    final injectDemo = ref.read(demoInjectorProvider);

    Future<void> pickProject() async {
      String? selectedDir = await FilePicker.platform.getDirectoryPath();
      if (selectedDir != null) {
        ref.read(projectPathProvider.notifier).state = selectedDir;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Select Flutter Project",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(status, textAlign: TextAlign.center),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: pickProject,
                  child: const Text(
                    "Pick Flutter Project Folder",
                    style: TextStyle(color: Colors.teal),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: installPackage,
                  child: const Text(
                    "Integrate google_maps_flutter",
                    style: TextStyle(color: Colors.teal),
                  ),
                ),
                const SizedBox(height: 10),
                if (packageStatus != null) Text(packageStatus),

                const SizedBox(height: 30),
                TextField(
                  onChanged: (value) => setApiKey.state = value,
                  decoration: InputDecoration(
                    labelText: "Enter Google Maps API Key",
                    labelStyle: const TextStyle(color: Colors.teal),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal, width: 2.0),
                    ),
                  ),
                  cursorColor: Colors.teal,
                  style: const TextStyle(color: Colors.black),
                ),

                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: handleApiKey,
                  child: const Text(
                    "Add API Key",
                    style: TextStyle(color: Colors.teal),
                  ),
                ),
                if (apiKeyStatus != null) ...[
                  const SizedBox(height: 10),
                  Text(apiKeyStatus),
                ],

                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: injectDemo,
                  child: const Text(
                    "Inject Google Map Example",
                    style: TextStyle(color: Colors.teal),
                  ),
                ),
                if (demoStatus != null) ...[
                  const SizedBox(height: 10),
                  Text(demoStatus),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
