import 'dart:async';
import 'package:flutter/material.dart';
import 'notification_service.dart';

class NotificationState extends ChangeNotifier {
  final NotificationService _notificationService = NotificationService();

  String? _fcmToken;
  bool _isLoading = false;
  String? _error;
  bool _isInitialized = false;
  StreamSubscription<String>? _tokenRefreshSubscription;

  String? get fcmToken => _fcmToken;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> initialize() async {
    if (_isInitialized || _isLoading) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _notificationService.initialize();
      _fcmToken = await _notificationService.getToken();

      _tokenRefreshSubscription =
          _notificationService.onTokenRefresh.listen((token) {
        _fcmToken = token;
        notifyListeners();
      });

      _isInitialized = true;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _tokenRefreshSubscription?.cancel();
    super.dispose();
  }
}
