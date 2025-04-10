import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/demo_injector_service.dart';
import '../services/pubspec_service.dart';
import '../services/api_key_service.dart';

final projectPathProvider = StateProvider<String?>((ref) => null);

final projectStatusProvider = Provider<String>((ref) {
  final path = ref.watch(projectPathProvider);
  if (path == null) return "No project selected.";

  return File('$path/pubspec.yaml').existsSync()
      ? "Valid Flutter project selected:\n$path"
      : "Invalid project: pubspec.yaml not found.";
});

final packageAddStatusProvider = StateProvider<String?>((ref) => null);

final packageInstallerProvider = Provider<Future<void> Function()>((ref) {
  return () async {
    final path = ref.read(projectPathProvider);
    if (path == null) return;

    ref.read(packageAddStatusProvider.notifier).state = "Adding package...";

    final added = await PubspecService.addGoogleMapsPackage(path);
    if (!added) {
      ref.read(packageAddStatusProvider.notifier).state =
          "Failed to add package.";
      return;
    }

    ref.read(packageAddStatusProvider.notifier).state =
        "Running flutter pub get...";

    final success = await PubspecService.runFlutterPubGet(path);

    if (success) {
      ref.read(packageAddStatusProvider.notifier).state =
          "Package integrated successfully!";
    } else {
      ref.read(packageAddStatusProvider.notifier).state =
          "Failed to run flutter pub get.";
    }
  };
});

final apiKeyProvider = StateProvider<String>((ref) => '');

final apiKeyStatusProvider = StateProvider<String?>((ref) => null);

final apiKeyManagerProvider = Provider<Future<void> Function()>((ref) {
  return () async {
    final path = ref.read(projectPathProvider);
    if (path == null) return;

    ref.read(apiKeyStatusProvider.notifier).state =
        "Checking existing API key...";

    final alreadyAdded = await ApiKeyService.isApiKeyPresent(path);
    if (alreadyAdded) {
      ref.read(apiKeyStatusProvider.notifier).state =
          "API key already configured.";
      return;
    }

    final key = ref.read(apiKeyProvider);
    if (key.isEmpty) {
      ref.read(apiKeyStatusProvider.notifier).state =
          "Please enter a valid API key.";
      return;
    }

    await ApiKeyService.addApiKey(path, key);
    ref.read(apiKeyStatusProvider.notifier).state =
        "API key added successfully!";
  };
});

final demoStatusProvider = StateProvider<String?>((ref) => null);

final demoInjectorProvider = Provider<Future<void> Function()>((ref) {
  return () async {
    final path = ref.read(projectPathProvider);
    if (path == null) return;

    ref.read(demoStatusProvider.notifier).state = "⚙️ Injecting map demo...";

    final success = await DemoInjectorService.addGoogleMapExample(path);
    ref.read(demoStatusProvider.notifier).state =
        success
            ? "Google Map demo added successfully!"
            : "Failed to inject demo.";
  };
});
