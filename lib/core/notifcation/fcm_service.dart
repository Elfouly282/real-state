import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FcmService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static String? _cachedToken;

  static Future<String?> initialize() async {
    // Permission is requested in main (`_bootstrapPushAndLinks`) before this runs.
    if (Platform.isIOS) {
      final settings = await _messaging.getNotificationSettings();
      if (settings.authorizationStatus != AuthorizationStatus.authorized) {
        debugPrint('❌ FCM: Notification permission not granted');
        return null;
      }
    }

    try {
      final token = await _messaging.getToken().timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          debugPrint(
            'FCM getToken timed out (often on iOS Simulator without APNS)',
          );
          return null;
        },
      );
      if (token != null) {
        _cachedToken = token;
        debugPrint('✅ FCM TOKEN: $token');
        return token;
      }
    } catch (e) {
      debugPrint('❌ FCM error: $e');
    }
    return null;
  }

  /// Get FCM token - returns cached token if available, otherwise gets new one
  static Future<String?> getToken() async {
    if (_cachedToken != null) {
      debugPrint('📱 FCM: Using cached token');
      return _cachedToken;
    }

    try {
      final token = await _messaging.getToken().timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          debugPrint('FCM getToken timed out');
          return null;
        },
      );
      if (token != null) {
        _cachedToken = token;
        debugPrint('✅ FCM: Got new token: $token');
        return token;
      }
    } catch (e) {
      debugPrint('❌ FCM getToken error: $e');
    }
    return null;
  }
}
