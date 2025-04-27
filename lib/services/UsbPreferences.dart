import 'dart:convert';
import 'dart:io';

class UsbPreferences {
  final Directory usbDirectory;

  UsbPreferences(this.usbDirectory);

  File get _settingsFile => File('${usbDirectory.path}/settings.json');

  Future<Map<String, dynamic>> _readPrefs() async {
    if (await _settingsFile.exists()) {
      final content = await _settingsFile.readAsString();
      return jsonDecode(content);
    }
    return {};
  }

  Future<void> setBool(String key, bool value) async {
    final prefs = await _readPrefs();
    prefs[key] = value;
    await _settingsFile.writeAsString(jsonEncode(prefs));
  }

  Future<bool?> getBool(String key) async {
    final prefs = await _readPrefs();
    return prefs[key] as bool?;
  }

  Future<void> setString(String key, String value) async {
    final prefs = await _readPrefs();
    prefs[key] = value;
    await _settingsFile.writeAsString(jsonEncode(prefs));
  }

  Future<String?> getString(String key) async {
    final prefs = await _readPrefs();
    return prefs[key] as String?;
  }
}
