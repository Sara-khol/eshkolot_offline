import 'dart:io';
import 'package:archive/archive.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    extractZipFile();
    return const Placeholder();
  }
}


void extractZipFile() {
  // Open the zip file
  String zipFilePath = r"F:\goapp\installation.eshkolot";
  String destDirPath = r"F:\goapp\eshkolot_offline\data";

// Open the zip file
  final bytes = File(zipFilePath).readAsBytesSync();
  final archive = ZipDecoder().decodeBytes(bytes);

// Loop through the contents of the zip file and extract the data files and videos
  for (final archiveFile in archive) {
    // Check if the file is a data file or video
    if (archiveFile.name.endsWith('.dart')) {
      // Extract the file to the destination directory
      final fileData = archiveFile.content;//as List<int>;
      final filePath = destDirPath + archiveFile.name;
      final extractedFile = File(filePath);
      extractedFile.createSync(recursive: true);
      extractedFile.writeAsBytesSync(fileData);
    }
    print(archiveFile.name);
  }
}