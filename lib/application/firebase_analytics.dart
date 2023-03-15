import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  Future logLogin() async {
    await _analytics.logLogin(loginMethod: 'Email');
  }

  Future logOut() async {
    await _analytics.logEvent(name: "Logout");
  }

  Future logFailed() async {
    await _analytics.logEvent(name: "LoginFailed");
  }
}
