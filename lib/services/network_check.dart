import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'localFileHelper.dart';

class NetworkConnectivity {
  NetworkConnectivity._();
  static final NetworkConnectivity _instance = NetworkConnectivity._();
  static NetworkConnectivity get instance => _instance;

  final Connectivity _connectivity = Connectivity();

  final StreamController<bool> _controller =
  StreamController<bool>.broadcast();

  Stream<bool> get stream => _controller.stream;

  bool whileDownloading = false;
  bool isOnline = false;
  bool _firstTime = true;

  int _internetFailCount = 0;
  ConnectivityResult _lastActiveResult = ConnectivityResult.none;

  StreamSubscription<List<ConnectivityResult>>? _subscription;
  Timer? _offlineDelayTimer;


  // --------------------------------------------------------

  Future<void> initialise() async {
    final results = await _connectivity.checkConnectivity();
    await _handleConnectivity(results);

    _subscription =
        _connectivity.onConnectivityChanged.listen((results) async {
          await _handleConnectivity(results);
        });
  }

  // --------------------------------------------------------

  Future<void> _handleConnectivity(
      List<ConnectivityResult> results) async {

    final hasNetwork =
    results.any((r) => r != ConnectivityResult.none);
    debugPrint('Connectivity results: $results');
    // אין רשת בכלל
    if (!hasNetwork) {

      // אם כבר יש טיימר – לא יוצרים עוד אחד
      if (_offlineDelayTimer != null) return;

      _offlineDelayTimer = Timer(const Duration(seconds: 2), () async {

        final retryResults =
        await _connectivity.checkConnectivity();

        final stillNoNetwork =
        retryResults.every((r) => r == ConnectivityResult.none);

        if (stillNoNetwork) {
          _internetFailCount = 0;
          _updateStatus(false);
        }

        _offlineDelayTimer = null;
      });

      return;
    }
    // אם חזרה רשת לפני שהטיימר הסתיים — מבטלים אותו
    _offlineDelayTimer?.cancel();
    _offlineDelayTimer = null;
    // שומרים את סוג החיבור האמיתי
    _lastActiveResult =
        results.firstWhere((r) => r != ConnectivityResult.none);

    final hasInternet = await _hasInternet();

    if (!hasInternet) {
      _internetFailCount++;

      if (_internetFailCount >= 2) {
        _updateStatus(false);
      }
      return;
    }

    _internetFailCount = 0;
    _updateStatus(true);
  }

  // --------------------------------------------------------

  void _updateStatus(bool newStatus) {
    if (isOnline == newStatus && !_firstTime) return;

    isOnline = newStatus;
    _firstTime = false;

    if (!_controller.isClosed) {
      _controller.add(isOnline);
    }

    if (isOnline) {
      sendStoredEvents();
      if (whileDownloading) {
        sendWhileDownloadingVideos(_lastActiveResult);
      }
    } else {
      if (whileDownloading) {
        sendWhileDownloadingVideos(ConnectivityResult.none);
      }
    }

    if (kDebugMode) {
      debugPrint('Network status changed: $isOnline');
    }
  }

  // --------------------------------------------------------

  Future<bool> _hasInternet() async {
    try {
      final client = HttpClient();
      client.connectionTimeout = const Duration(seconds: 5);

      final request = await client
          .getUrl(Uri.parse('https://clients3.google.com/generate_204'));

      request.followRedirects = false;

      final response = await request.close();
      final success = response.statusCode == 204;

      client.close();
      return success;
    } catch (_) {
      return false;
    }
  }

  // --------------------------------------------------------

  void sendStoredEvents() async {
    final List<String> events = await LocalFileHelper().readEvents();
    for (final eventJson in events) {
      final event = SentryEvent.fromJson(json.decode(eventJson));
      await Sentry.captureEvent(event);
      await LocalFileHelper().deleteEvent(eventJson);
    }
  }

  void sendWhileDownloadingVideos(ConnectivityResult result) {
    if (kDebugMode) {
      debugPrint('Download status changed: $result');
    }
  }

  Future<bool> checkNow() async {
    final results = await _connectivity.checkConnectivity();
    final hasNetwork =
    results.any((r) => r != ConnectivityResult.none);

    if (!hasNetwork) return false;

    return await _hasInternet();
  }


  // --------------------------------------------------------

  void dispose() {
    _subscription?.cancel();
    _controller.close();
  }


}
