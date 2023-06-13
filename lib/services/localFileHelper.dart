import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class LocalFileHelper {

  LocalFileHelper._privateConstructor();

  static final LocalFileHelper _instance = LocalFileHelper._privateConstructor();

  factory LocalFileHelper() => _instance;

   Future<String> get _localPath async {
    final directory = await getApplicationSupportDirectory();
    return directory.path;
  }

   Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/events.txt');
  }

   Future<File> writeEvent(String eventJson) async {
    final file = await _localFile;
    return file.writeAsString('$eventJson\n', mode: FileMode.append);
  }

   Future<List<String>> readEvents() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsLines();
      return contents;
    } catch (e) {
      return [];
    }
  }

   Future<File> deleteEvent(String eventJson) async {
    final file = await _localFile;
    final contents = await file.readAsLines();
    contents.remove(eventJson);
    return file.writeAsString(contents.join('\n'));
  }
}
