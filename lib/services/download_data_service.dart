import 'dart:async';


import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:eshkolot_offline/models/course.dart';
import 'package:eshkolot_offline/models/linkQuizIsar.dart';
import 'package:eshkolot_offline/models/quiz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sentry_dio/sentry_dio.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'installationDataHelper.dart';
import 'isar_service.dart';
import 'network_check.dart';
import 'package:eshkolot_offline/utils/constants.dart' as constants;

class DownloadService with ChangeNotifier {
  String token = '1234e6802e12410d1130b9fa774d4cd0'; //privet video files

  int projectId = 0; //english
  //int quizId = 0; //english
  Dio dioDownload = Dio();
  int numDownloadFiles = 0, numOfErrorFiles = 0;
  late DownloadStatusData downloadStatus, lastDownLoadStatus;
  late String currentLink;
  List<String> blockLinks = [];
  List<String> errorLinks = [];
  int errorTries = 0;
  List<Course> courses = [];
  int numOfAllFiles = 0;
  int numOfCourses = 0;
  CancelToken cancelToken = CancelToken();
  late String path;
  final NetworkConnectivity _networkConnectivity = NetworkConnectivity.instance;
  List<int> courseIds = [];

  Map _source = {ConnectivityResult.none: false};

  // final NetworkConnectivity _networkConnectivity = NetworkConnectivity.instance;
  late bool isNetWorkConnection = false;
  bool isDispose = false;
  late StreamSubscription subscription;
  Timer? timer;
  int captureMessageNum = 1;
  bool wasInit = false;
  bool tryAgain = false;
  bool coursesNotCompleted = false;
  bool didCheckCompleted = false;
  late SharedPreferences preferences;

  DownloadService._privateConstructor(); // Private constructor for singleton

  bool isCancelled = false;
  List<CancelToken> cancelTokens = [];

  static final DownloadService _instance =
      DownloadService._privateConstructor();

  factory DownloadService() {
    return _instance;
  }

  init() async {
    if (!wasInit) {
      debugPrint("downloadService init");
      didCheckCompleted = false;
      isCancelled = false;
      // _networkConnectivity.whileDownloading = true;
      // _networkConnectivity.initialise();
      preferences = await SharedPreferences.getInstance();

      subscription = _networkConnectivity.myStream.listen((source) async {
        _source = source;
        debugPrint('source222 $_source');
        if (_source.keys.toList()[0] == ConnectivityResult.none) {
          // if (downloadStatus != DownloadStatus.netWorkError) {
          if (timer != null && timer!.isActive) {
            timer!.cancel();
          }
          isNetWorkConnection = false;
          //  downloadStatus = DownloadStatus.netWorkError;
          notifyListeners();
          //   cancelToken.cancel('wwwwwww');
          cancelAllDownloads();

          debugPrint('no connection so cancel downloading');
          Sentry.addBreadcrumb(
              Breadcrumb(message: 'no connection so cancel downloading'));
          // }
        } /*else {
          // if (downloadStatus == DownloadStatus.netWorkError) {
          downloadStatus = lastDownLoadStatus;
          notifyListeners();
          isNetWorkConnection = true;
          //if in middle to download videos

          debugPrint('jjjj ${getAllDownloaded().map((v) => v.id)}');
          debugPrint('jjjj ${getAllDownloaded().length}');

          debugPrint('aaaaagain');
          if (cancelToken.isCancelled) {
            cancelToken = CancelToken();
          }
          startDownLoading(wasNetWorkProblem: true);
        }*/
        //}
      });

      coursesNotCompleted = false;

      //dioDownload.interceptors.add(interceptorsWrapper);
      dioDownload.addSentry();
      wasInit = true;
    } else {
      debugPrint("downloadService already init");
    }
  }

  // downloadQuizFiles(List<String> urls, int quizId, int courseId) {
  //   //  debugPrint("quizId $quizId length ${urls.length}");
  //
  //   numOfAllFiles = urls.length;
  //   this.quizId = quizId;
  //   for (String s in urls) {
  //     String name = s.substring(s.lastIndexOf('/'), s.length);
  //     if (/*!name.endsWith('.pdf') &&*/
  //         /* !name.endsWith('.mp4') &&*/
  //         !s.contains('player.vimeo.com') /*&& !s.contains('wordpress')*/) {
  //       isarLinksList.add(LinkQuizIsar()
  //         ..quizId = quizId
  //         ..courseId = courseId
  //         ..name = name
  //         ..downloadLink = s);
  //     downloadFile(s, name, quizId, courseId);
  //
  //     } else {
  //       numDownloadFiles++;
  //     }
  //   }
  //  // _downloadInBatches(urls,courseId);
  // }

  downloadQuizFiles(List<CC> urls, int courseId, bool isNewCourse) async {
    debugPrint('isCancelled $isCancelled');
    if (!isCancelled) {
      debugPrint(
          "courseId $courseId length ${urls.length} isNewCourse $isNewCourse");

      numOfAllFiles = urls.length;
      List<Future<void>> downloadTasks = [];

      // Limit the number of concurrent downloads
      const int maxConcurrentDownloads = 100;
      if (isNewCourse) {
        for (CC s in urls) {
          String name = s.url.substring(s.url.lastIndexOf('/'), s.url.length);
          IsarService().addIsarQuiz(LinkQuizIsar()
            ..quizId = s.quizId
            ..courseId = courseId
            ..name = name
            ..downloadLink = s.url);
        }
      }
      // final Stream<CC> urlStream = Stream.fromIterable(urls);
      //final StreamSubscription<CC> urlSubscription = urlStream.listen((CC s) async {
      int urlNum = 0;
      for (CC s in urls) {
        urlNum++;
        String name = s.url.substring(s.url.lastIndexOf('/') + 1, s.url.length);

        CancelToken cancelToken = CancelToken();
        cancelTokens.add(cancelToken);

        // if (!s.url.contains('player.vimeo.com')) {

        //if(downloadTasks.length<maxConcurrentDownloads || urlNum!=urls.length ) {
        downloadTasks
            .add(downloadFile(s.url, name, s.quizId, courseId, cancelToken));
        //}
        if (downloadTasks.length == maxConcurrentDownloads ||
            urlNum == urls.length) {
          await Future.wait(downloadTasks);
          debugPrint(
              'course ${courseId} download ${downloadTasks.length} files ');

          downloadTasks.clear();
        }
        // } else {
        //  numDownloadFiles++;
        //}
        if (isCancelled) {
          break;
        }
      }

      if (!isCancelled) {
        debugPrint('course ${courseId} download finish ');

        downloadTasks.clear();

        await IsarService().updateCourseDownloadFiles(courseId);
        numOfCourses++;
        checkCompleted();
      } else {
        debugPrint('was canceled!!!');
      }
    }
  }

  startDownLoadingBlockedLinks(List<LinkQuizIsar> list,
      {bool wasNetWorkProblem = false, bool notify = false}) async {
    tryAgain = true;
    didCheckCompleted = false;
    // if (isNetWorkConnection) {
    debugPrint('startDownLoadingBlockedLinks');
    numOfErrorFiles = 0;
    downloadStatus = DownloadStatusData.downloading;
    lastDownLoadStatus = DownloadStatusData.downloading;
    if (notify) notifyListeners();

    if (cancelToken.isCancelled) {
      cancelToken = CancelToken();
    }

    numDownloadFiles = 0;
    blockLinks = [];
    errorLinks = [];

    numOfAllFiles = list.length;
    debugPrint('numOfAllFiles $numOfAllFiles');
    Sentry.addBreadcrumb(Breadcrumb(message: 'numOfAllVideos $numOfAllFiles'));

    if (numOfAllFiles == 0) {
      downloadStatus = DownloadStatusData.downloaded;
      notifyListeners();
    } else {
      // setTimer();

      for (LinkQuizIsar l in list) {
        CancelToken cancelToken = CancelToken();
        cancelTokens.add(cancelToken);
        if (wasNetWorkProblem) {
          // debugPrint('awaittttttttt');
          await downloadFile(
              l.downloadLink, l.name, l.quizId, l.courseId, cancelToken,
              id: l.id);
        } else {
          // debugPrint('nooo await');
          downloadFile(
              l.downloadLink, l.name, l.quizId, l.courseId, cancelToken,
              id: l.id);
        }
      }
    }
    /* } else {
      downloadStatus = DownloadStatusData.netWorkError;
      lastDownLoadStatus = DownloadStatusData.netWorkError;
      if (notify) notifyListeners();
      debugPrint('no network');
      Sentry.addBreadcrumb(Breadcrumb(message: 'no network'));
    }*/
  }

  bool isValidFileName(String fileName) {
    RegExp regExp = RegExp(r'[<>:"/\\|?*]');
    return !regExp.hasMatch(fileName);
  }

  String removeUnsupportedChars(String fileName) {
    RegExp regExp = RegExp(r'[<>:"/\\|?*]');
    return fileName.replaceAll(regExp, '_');
  }

  changeQuizUsingProblematicFileName(
      Quiz quiz, String fileName, fixedFileName) {
    debugPrint('fileName $fileName');
    debugPrint('fixedFileName $fixedFileName');
    for (Question question in quiz.questionList) {
      if (question.question.contains(fileName)) {
        question.question= question.question.replaceAll(fileName, fixedFileName);
        debugPrint('changed!! question ${question.question}');

      }
      if (question.type == QType.customEditor) {
        if (question.moreData != null) {
          for (CustomQuizQuestionsFields f in question.moreData!.quizFields) {
            if (f.type == 'image' && f.defaultValue.contains(fileName)) {
              f.defaultValue= f.defaultValue.replaceAll(fileName, fixedFileName);
              debugPrint('changed!! defaultValue ${f.defaultValue}');

            }
          }
        }
      }
    }
    IsarService().updateQuiz(quiz);
  }

  Future<void> downloadFile(
      String url, String name, int qId, int courseId, CancelToken cancelToken,
      {int id = 0}) async {
    String progress = '';

    if (!isValidFileName(name)) {
      String oldName=name;;
      debugPrint("File name is not valid: $name");

      name = '${removeUnsupportedChars(name)}.png';

      // Proceed with saving the file
      debugPrint("change name: $name");

      Quiz? quiz = await IsarService().getQuizById(qId);
      changeQuizUsingProblematicFileName(quiz!,oldName,name);
    }

    var dir =
        await getApplicationSupportDirectory(); //C:\Users\USER\AppData\Roaming\GoApp\eshkolot_offline
    // dir = Directory(path);
    // if(!dir.existsSync())
    //   {
    //     await dir.create();
    //   }
    await dioDownload.download(
      url,
      cancelToken: cancelToken,
      '${dir.path}/${constants.quizPath}/$qId/$name',
      onReceiveProgress: (rec, total) {
        progress = ((rec / total) * 100).toStringAsFixed(0);
      },
    ).then((_) async {
      if (name.split('.').last != 'mp4' || progress == '100') {
        numDownloadFiles++;
        debugPrint(
            'name $name qId $qId numDownloadFiles $numDownloadFiles courseId $courseId');
        if (id == 0) {
          await IsarService().updateLinkQuizByName(name, qId);
        }
        //when downloading again blocked links
        if (id != 0) {
          await IsarService().updateLinkQuiz(id);
        }
        if (tryAgain) checkCompleted();

        // IsarService().updateIsarLinkQuiz(int.parse(name.substring(1)));
      }
    }).catchError((e) async {
      if (e is DioException && CancelToken.isCancel(e)) {
        debugPrint('CancelToken.isCancel');
        numOfErrorFiles++;
        // if (!blockLinks.contains(url)) {
        //   blockLinks.add(url);
        // }
        // if (id == 0 || !await IsarService().checkIsarQuizExistes(id)) {
        //   IsarService().addIsarQuiz(LinkQuizIsar()
        //     ..courseId = courseId
        //     ..downloadLink = url
        //     ..quizId = qId
        //     ..name = name
        //     ..isBlock = false
        //     ..isDownload = false);
        // }
      } else {
        numOfErrorFiles++;
        if (!blockLinks.contains(url)) {
          blockLinks.add(url);
        }
        // if (id == 0 || !await IsarService().checkIsarQuizExistes(id)) {
        // await  IsarService().addIsarQuiz(LinkQuizIsar()
        //     ..courseId = courseId
        //     ..downloadLink = url
        //     ..quizId = qId
        //     ..name = name
        //     ..isBlock = e.message!=null  && e.message.contains('418')
        //     ..isDownload = false);
        // }
        if (e is DioException &&
            e.message != null &&
            e.message!.contains('418')) {
          debugPrint('block $url quizId: $qId courseId $courseId');
          Sentry.addBreadcrumb(Breadcrumb(
              message: 'block $url quizId: $qId courseId $courseId'));
        } else {
          debugPrint(
              'erorrrr download quiz file: ${e} quizId: $qId url $url numOfErrorFiles $numOfErrorFiles');
          Sentry.addBreadcrumb(Breadcrumb(
              message:
                  'erorrrr download quiz file: ${e} quizId: $qId url $url'));
        }
        if (tryAgain) checkCompleted();
      }
    });
  }

  void cancelAllDownloads() {
    debugPrint('cancelAllDownloads');
    isCancelled = true;
    for (final cancelToken in cancelTokens) {
      cancelToken.cancel();
    }
    cancelTokens.clear();
  }

  checkCompleted() async {
    int myNum =
        tryAgain ? numOfAllFiles : InstallationDataHelper().numOfQuizUrls;
    debugPrint(
        'checkCompleted ${numDownloadFiles + numOfErrorFiles} $myNum numOfCourses $numOfCourses numOfCoursesDownloadQuiz ${InstallationDataHelper().numOfCoursesDownloadQuiz}');
    if (numDownloadFiles + numOfErrorFiles == myNum &&
        numOfCourses == InstallationDataHelper().numOfCoursesDownloadQuiz) {
      if (!didCheckCompleted) {
        debugPrint(
            'all downloaded!! $myNum $numDownloadFiles $numOfErrorFiles');
        didCheckCompleted = true;

        preferences.setBool('downloadFiles', true);
        //added this condition - coursesNotCompleted when internet stops in middle of
        // downloading quiz when starts again it will download videos from start
        List<int> idsNotCompleted;
        // coursesNotCompleted= await IsarService().checkCoursesNotCompleted(courseIds);
        idsNotCompleted =
            await IsarService().checkCoursesNotCompleted(courseIds);
        for (int id in idsNotCompleted) {
          debugPrint('idNotCompleted $id');
        }
        if (courseIds.isNotEmpty) {
          debugPrint('courseIds $courseIds');
          coursesNotCompleted = courseIds.length == idsNotCompleted.length;
        } else {
          coursesNotCompleted = idsNotCompleted.isNotEmpty;
          courseIds = idsNotCompleted;
        }
        debugPrint('coursesNotCompleted $coursesNotCompleted');
        if (!tryAgain || coursesNotCompleted) {
          // IsarService().updateCourseDownloaded(courseIds);
          debugPrint('sending event full');
          InstallationDataHelper()
              .eventBusDialogs
              .fire(InstallationDataHelper().coursesList);
          InstallationDataHelper().coursesList = [];
        } else {
          InstallationDataHelper().eventBusDialogs.fire('quiz');
        }
      }
    }
  }

/*  deleteFilesInDirectoryBeforeDownloading() async {
    Directory dir = await getApplicationSupportDirectory();
    // final targetFile = Directory("${dir.path}/books/$fileName.pdf");
    final targetFile = Directory('${dir.path}/${constants.quizPath}/$quizId');
    if (targetFile.existsSync()) {
      targetFile.deleteSync(recursive: true);
    }
    debugPrint('all delete');
  }*/

  /* setTimer() {
    if (timer == null || !timer!.isActive) {
      // int minuteToWait = ((numOfAllVideos * 12) / 60).ceil();
      int minuteToWait = 30;
      debugPrint('minuteToWait $minuteToWait');
      Sentry.addBreadcrumb(Breadcrumb(message: 'minuteToWait $minuteToWait'));
      timer = Timer(Duration(minutes: minuteToWait), () async {
        tryAgainFromStart();
      });
    }
  }*/

  /* checkErrors() async {
    if (blockLinks.length + numDownloadFiles + errorLinks.length ==
        numOfAllFiles) {
      debugPrint('problemmmmm');
      if (timer != null && timer!.isActive) {
        timer!.cancel();
      }

      if (errorLinks.isNotEmpty) {
        debugPrint('errorrrr');
        Sentry.addBreadcrumb(
            Breadcrumb(message: 'errorrrr errorLinks.isNotEmpty'));

        errorTries++;
        if (errorTries < 3) {
          debugPrint('error links start again');
          await Sentry.captureMessage(
              'my downloading data error links trying again errorTries  $errorTries');
          startDownLoading();
        } else {
          await Sentry.captureMessage(
              'my downloading data error links display error errorTries $errorTries');
          downloadStatus = DownloadStatusData.error;
          notifyListeners();
        }
      } else {
        if (blockLinks.isNotEmpty) {
          debugPrint('blocked linksssssssssss');

          Sentry.addBreadcrumb(Breadcrumb(message: 'blocked linksssssssssss'));
          await Sentry.captureMessage(
              'my downloading data blocked links error ');
          //todo change..
          downloadStatus = DownloadStatusData.blockError;
          //downloadStatus = DownloadStatus.downloaded;

          notifyListeners();
        }
      }
    }
  }*/

  @override
  void dispose() async {
    if (!isDispose) {
      debugPrint('disssss');
      // if (blockLinks.isNotEmpty) {
      //   await Sentry.captureMessage('my downloading data blocked links error ');
      // } else {
      //todo remove condition when disable block links options to go on
      if (blockLinks.isEmpty) {
        await Sentry.captureMessage(
            'my downloading data ok $captureMessageNum');
      }
      isDispose = true;
      subscription.cancel();
      //makes a problem
      // _networkConnectivity.disposeStream();
      // _networkConnectivity.whileDownloading = false;

      if (timer != null && timer!.isActive) {
        timer!.cancel();
      }
      cancelAllDownloads();
      super.dispose();
    }
  }
}

enum DownloadStatusData {
  blockError,
  downloading,
  downloaded,
  error,
  netWorkError,
  // allDownloaded
}
