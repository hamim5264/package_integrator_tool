import 'dart:io';

class ApiKeyService {
  static Future<bool> isApiKeyPresent(String projectPath) async {
    final androidManifestPath =
        '$projectPath/android/app/src/main/AndroidManifest.xml';
    final iosPlistPath = '$projectPath/ios/Runner/Info.plist';

    bool androidHasKey = await File(androidManifestPath).readAsString().then(
      (content) => content.contains('com.google.android.geo.API_KEY'),
      onError: (_) => false,
    );

    bool iosHasKey = await File(iosPlistPath).readAsString().then(
      (content) => content.contains('GMSApiKey'),
      onError: (_) => false,
    );

    return androidHasKey && iosHasKey;
  }

  static Future<void> addApiKey(String projectPath, String apiKey) async {
    await _addAndroidConfig(projectPath, apiKey);
    await _addiOSConfig(projectPath, apiKey);
  }

  static Future<void> _addAndroidConfig(
    String projectPath,
    String apiKey,
  ) async {
    final androidManifestPath =
        '$projectPath/android/app/src/main/AndroidManifest.xml';
    final manifestFile = File(androidManifestPath);
    String content = await manifestFile.readAsString();

    if (!content.contains('com.google.android.geo.API_KEY')) {
      content = content.replaceFirst(
        '<application',
        '''<application>
        <meta-data android:name="com.google.android.geo.API_KEY" android:value="$apiKey"/>''',
      );
    }

    // Add permissions if not present
    if (!content.contains('android.permission.INTERNET')) {
      content = content.replaceFirst(
        '<manifest',
        '''<manifest>
        <uses-permission android:name="android.permission.INTERNET"/>
        <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>''',
      );
    }

    await manifestFile.writeAsString(content);
  }

  static Future<void> _addiOSConfig(String projectPath, String apiKey) async {
    final iosPlistPath = '$projectPath/ios/Runner/Info.plist';
    final plistFile = File(iosPlistPath);
    String content = await plistFile.readAsString();

    if (!content.contains('GMSApiKey')) {
      content = content.replaceFirst('</dict>', '''
  <key>GMSApiKey</key>
  <string>$apiKey</string>
</dict>''');
    }

    if (!content.contains('NSLocationWhenInUseUsageDescription')) {
      content = content.replaceFirst('</dict>', '''
  <key>NSLocationWhenInUseUsageDescription</key>
  <string>We need access to your location to show maps.</string>
</dict>''');
    }

    await plistFile.writeAsString(content);
  }
}
