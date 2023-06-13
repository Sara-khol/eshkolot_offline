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
  final _controller = StreamController.broadcast();
  Stream get myStream => _controller.stream;
   bool whileDownloading=false;
   late bool isOnline;
   late bool _firstTime;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  late  ConnectivityResult result;

  void initialise() async {
    _firstTime=true;
     result = await _networkConnectivity.checkConnectivity();
    isOnline = result != ConnectivityResult.none ? true : false;
    _checkStatus(result);
    _connectivitySubscription= _networkConnectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });

  }

  void _checkStatus(ConnectivityResult result) async {
    if (result == ConnectivityResult.none && isOnline) {
      // if(isOnline) {
        isOnline = false;
        debugPrint('Network disconnected whileDownloading $whileDownloading');
        sendWhileDownloadingVideos(result);
     // }
    } else {
      if (result != ConnectivityResult.none && (!isOnline || _firstTime)) {
        isOnline = true;
        if(_firstTime){_firstTime=false;}
        debugPrint('Network connected whileDownloading $whileDownloading');
        sendStoredEvents();
       sendWhileDownloadingVideos(result);
      }
    }}

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
      _controller.sink.add({result: isOnline});
    }
  }

  Future<bool> checkConnectivity() async {
     if  ( await _networkConnectivity.checkConnectivity() == ConnectivityResult.none) {
      return false;
    }
    return true;
  }

  void disposeStream() => _controller.close();

  // Stop listening to network connectivity changes
  void stopListeningToConnectivity() {
    _connectivitySubscription.cancel();
  }

}