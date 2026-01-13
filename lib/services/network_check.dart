import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'localFileHelper.dart';

class NetworkConnectivity {

  NetworkConnectivity._();
  static final _instance = NetworkConnectivity._();
  static NetworkConnectivity get instance => _instance;
  final _networkConnectivity = Connectivity();
  var _controller = StreamController.broadcast();
  Stream get myStream => _controller.stream;
   bool whileDownloading=false;
   late bool isOnline;
   late bool _firstTime;
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  late  List<ConnectivityResult> result;
  late ConnectivityResult _lastActiveResult;


  // void initialise1() async {
  //   _firstTime=true;
  //    result = await _networkConnectivity.checkConnectivity();
  //   isOnline = result != ConnectivityResult.none ? true : false;
  //   _checkStatus(result.first);
  //   _connectivitySubscription= _networkConnectivity.onConnectivityChanged.listen((result) {
  //     debugPrint('result $result');
  //     _checkStatus(result.first);
  //   });
  //
  // }

  void initialise() async {
    _firstTime = true;

    final results = await _networkConnectivity.checkConnectivity();
    final hasNetwork = results.any((r) => r != ConnectivityResult.none);

    if (hasNetwork) {
      _lastActiveResult = _pickActiveResult(results);
    }

    isOnline = hasNetwork;
    _checkStatus(hasNetwork);

    _connectivitySubscription =
        _networkConnectivity.onConnectivityChanged.listen((results) async {
          debugPrint('result $results');

          final stableOnline = await isOnlineStable(results);

          if (stableOnline) {
            _lastActiveResult = _pickActiveResult(results);
          }

          _checkStatus(stableOnline);
        });
  }


  // void _checkStatus1(ConnectivityResult result) async {
  //   if (result == ConnectivityResult.none && isOnline) {
  //     // if(isOnline) {
  //       isOnline = false;
  //       debugPrint('Network disconnected whileDownloading $whileDownloading');
  //       sendWhileDownloadingVideos(result);
  //    // }
  //   } else {
  //     if (result != ConnectivityResult.none && (!isOnline || _firstTime)) {
  //       isOnline = true;
  //       if(_firstTime){_firstTime=false;}
  //       debugPrint('Network connected whileDownloading $whileDownloading');
  //       sendStoredEvents();
  //      sendWhileDownloadingVideos(result);
  //     }
  //   }}

  void _checkStatus(bool onlineNow) {
    // מעבר ל־Offline
    if (!onlineNow && isOnline) {
      isOnline = false;
      debugPrint('Network disconnected whileDownloading $whileDownloading');
      sendWhileDownloadingVideos(ConnectivityResult.none);
      return;
    }

    // מעבר ל־Online
    if (onlineNow && (!isOnline || _firstTime)) {
      isOnline = true;
      if(_firstTime){_firstTime=false;}
      debugPrint('Network connected whileDownloading $whileDownloading');
      sendStoredEvents();
      sendWhileDownloadingVideos(_lastActiveResult); // סימלי
    }
  }


  void sendStoredEvents() async {
      final List<String> events = await LocalFileHelper().readEvents();
      for (final eventJson in events) {
        final event = SentryEvent.fromJson(json.decode(eventJson)) ;
        await Sentry.captureEvent(event);
        await LocalFileHelper().deleteEvent(eventJson);
    }
  }

  sendWhileDownloadingVideos(ConnectivityResult result)
  {
    if(whileDownloading) {
      debugPrint('1212');
      //todo?? remove makes problems
      if (!_controller.isClosed) {
        debugPrint('3434');
        _controller.sink.add({result: isOnline});
      }
    }
  }

  // Future<bool> checkConnectivity() async {
  //
  //    if  ( (await _networkConnectivity.checkConnectivity()).first == ConnectivityResult.none) {
  //     return false;
  //   }
  //   return true;
  // }

  Future<bool> isOnlineStable([List<ConnectivityResult>? initialResults]) async {
    // שלב 1: רשת
    bool hasNetwork = await _hasNetwork(initialResults);

    // שלב 2: retry קצר לרשת
    if (!hasNetwork) {
      await Future.delayed(const Duration(milliseconds: 600));
      hasNetwork = await _hasNetwork();
      if (!hasNetwork) return false;
    }

    // שלב 3: אינטרנט אמיתי (עם retry)
    for (int i = 0; i < 2; i++) {
      if (await _hasInternet()) return true;
      await Future.delayed(const Duration(milliseconds: 500));
    }

    return false;
  }

  Future<bool> _hasNetwork([List<ConnectivityResult>? initialResults]) async {
    late List<ConnectivityResult> results;
    if(initialResults==null) {
       results = await _networkConnectivity.checkConnectivity();
    }
    else
      {
         results=initialResults;
      }
    return results.any((r) => r != ConnectivityResult.none);
  }

  ConnectivityResult _pickActiveResult(List<ConnectivityResult> results) {
    return results.firstWhere(
          (r) => r != ConnectivityResult.none,
      orElse: () => ConnectivityResult.none,
    );
  }

  Future<bool> _hasInternet() async {
    try {
      final result = await InternetAddress.lookup('example.com')
          .timeout(const Duration(seconds: 3));
      return result.isNotEmpty && result.first.rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  void disposeStream() => _controller.close();

  void reOpen() {
    _controller.close(); // Dispose of the previous stream controller.
    _controller = StreamController.broadcast(); // Create a new stream controller.
  }

  // Stop listening to network connectivity changes
  void stopListeningToConnectivity() {
    _connectivitySubscription.cancel();
  }



}