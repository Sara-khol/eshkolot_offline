// services/sync_manager.dart
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/network_check.dart';
import '../services/api_service.dart';
import '../services/isar_service.dart';
import '../services/installationDataHelper.dart';
import '../ui/screens/main_page/main_page.dart';
import '../ui/screens/home_page.dart';
import '../ui/screens/course_main/main_page_child.dart';
import '../ui/screens/dialogs/sync_dialogs.dart';
import '../services/download_data_service.dart';

class SyncManager {
  static Future<void> sync(BuildContext appContext) async {
    if (await NetworkConnectivity.instance.isOnlineStable()) {
      await _syncFunc(appContext);
      if (!appContext.mounted) return;
      showDialog(
        context: appContext,
        barrierDismissible: false,
        builder: (_) => const SyncDialogs(),
      );
    } else {
      if (!appContext.mounted) return;
      showDialog(
        context: appContext,
        barrierDismissible: false,
        builder: (_) => const SyncDialogs(isOffline: true),
      );
    }
  }

  static Future<void> _syncFunc(BuildContext appContext) async {
    // Refresh relevant pages
    final main = MainPage.of(appContext);
    if (main?.getMainWidget is HomePage) {
      InstallationDataHelper().eventBusHomePage.fire('event fire');
    } else if (main?.getMainWidget is MainPageChild) {
      InstallationDataHelper().eventBusMainPageChild.fire('event fire');
    }
    InstallationDataHelper().eventBusSideMenu.fire('');

    // Build payload
    final user = IsarService().getCurrentUser();
    final courseCompleted = user.courses
        .where((c) => c.status == Status.finish)
        .map((c) => c.courseId)
        .toList();
    final percentagesJson = user.percentages.map((g) => g.toJson()).toList();

    final payload = {
      'id_user': user.id,
      'lessonCompleted': user.lessonCompleted,
      'questionCompleted': user.questionCompleted,
      'subjectCompleted': user.subjectCompleted,
      'coursesCompleted': courseCompleted,
      'percentages': percentagesJson,
      'user_type': user.userType,
      'user_mail': user.userMail,
    };

    DownloadService().blockLinks = [];

    ApiService().syncData(
      onSuccess: (bool getVideos) {
        final main2 = MainPage.of(appContext);
        if (main2?.getMainWidget is HomePage) {
          InstallationDataHelper().eventBusHomePage.fire('event fire');
        } else if (main2?.getMainWidget is MainPageChild) {
          InstallationDataHelper().eventBusMainPageChild.fire('event fire');
        }
        InstallationDataHelper().eventBusSideMenu.fire('');
      },
      onError: () {},
      jsonMap: payload,
    );
  }
}
