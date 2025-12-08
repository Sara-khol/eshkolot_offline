
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';


class CommonFuncs
{

  // Singleton pattern
  static final CommonFuncs _instance = CommonFuncs._internal();

  factory CommonFuncs() => _instance;

  CommonFuncs._internal();

  Directory? _cachedEshkolotDirectory;
  bool _isUsb = false;


  void showMyToast(String message, { int duration = 3}) {
    Widget widget = /*Container(
        margin: EdgeInsets.only(bottom: 80.h),
        padding: EdgeInsets.only(right: 30.w, left: 30.w),
        child:*/ ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: Container(
            padding: EdgeInsets.all(20.w),
            color: Colors.black87,
            child: Text(
              message,
              style: TextStyle(color: Colors.white, fontSize: 20.sp,fontFamily:'RAG-Sans' ),
              textAlign: TextAlign.center,
            ),
          ),
       // )
    );

    showToastWidget(
      widget,
      duration: Duration(seconds: duration),
      onDismiss: () {},

      position: ToastPosition.bottom,
    );
  }

  Future<Directory?> findEshkolotDirectoryInDrive(String drive) async {
    final baseDir = Directory('$drive:\\');
    try {
    if (!await baseDir.exists()) return null;

    await for (final entity in baseDir.list()) {
      if (entity is Directory) {
        final dirName = entity.path.split('\\').last;
        final cleaned = cleanDirectoryName(dirName);
        debugPrint('cleaned $cleaned');
        if (cleaned == '.eshkolot_system') {
          // final innerPath = '${entity.path}\\.eshkolot_system';
          // final innerDir = Directory(innerPath);
           final myDir = Directory(entity.path);

          if (await myDir.exists()) {
            debugPrint('Found eshkolot folder: ${myDir.path}');
            return myDir;
          }
        }
      }
    }} catch (e) {
      debugPrint('Error accessing drive $drive: $e');
      return null;
    }

    return null;
  }

  String removeHiddenCharsFromPath(String path) {
    // Replace all whitespace characters with empty strings
    path = path.replaceAll(RegExp(r'\s+'), '');

    // You can add more specific replacements here for other hidden characters if needed.
    return path;
  }

  /// Remove invisible/control/RTL characters from directory names
  String cleanDirectoryName(String name) {
    return name.replaceAll(RegExp(r'[\x00-\x1F\x7F\u200E\u200F\u202A-\u202E]'), '');
  }

  /// Main function to get the working directory with caching
  Future<Directory> getEshkolotWorkingDirectory() async {
  //  debugPrint('getEshkolotWorkingDirectory $_cachedEshkolotDirectory');
    // ✅ Return cached directory if available
    if (_cachedEshkolotDirectory != null) {
      return _cachedEshkolotDirectory!;
    }

    const driveLetters = ['D', 'E', 'F', 'G', 'H', 'I'];

    for (String drive in driveLetters) {
      final dir = await findEshkolotDirectoryInDrive(drive);
      if (dir != null) {
        debugPrint('getEshkolotWorkingDirectory new directory$dir');
        Sentry.addBreadcrumb(Breadcrumb(message: 'getEshkolotWorkingDirectory $dir'));

        _cachedEshkolotDirectory = dir;
        _isUsb=true;
        return dir;
      }
    }

    // fallback ל־AppData
    debugPrint('Did not find USB drive, falling back to app data');
    final fallback = await getApplicationSupportDirectory();
    _cachedEshkolotDirectory = fallback;
    _isUsb=false;
    return fallback;
  }

  checkIfUsb()
  {
    debugPrint('checkIfUsb $_isUsb');
    return _isUsb;
  }

}

