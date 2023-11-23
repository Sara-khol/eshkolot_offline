import 'dart:io';
import 'package:archive/archive.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

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


void extractZipFile() async {
  // Open the zip file
  String zipFilePath = r"c:\installation.eshkolot";
  // String zipFilePath = r"C:\Users\USER\GoAppProjects\eshkolot_offline\vvv.eshkolot";
  final Directory directory = await getApplicationSupportDirectory();
  String destDirPath = directory.path;


// Open the zip file
  final bytes = File(zipFilePath).readAsBytesSync();
  final archive = ZipDecoder().decodeBytes(bytes);

// Loop through the contents of the zip file and extract the data files and videos
  for (final archiveFile in archive) {
    // Check if the file is a data file or video
   if (archiveFile.name.endsWith('.json')) {
      // Extract the file to the destination directory
      final fileData = archiveFile.content;//as List<int>;
      final filePath = '$destDirPath/${archiveFile.name}';
      // final filePath = '${directory.path}/mydata/';
      final extractedFile = File(filePath);
      extractedFile.createSync(recursive: true);
      extractedFile.writeAsBytesSync(fileData);
   }
    debugPrint(archiveFile.name);
  }
}