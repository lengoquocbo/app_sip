import 'package:flutter/material.dart';
import '../screens/dial_screen.dart';
import '../screens/history_screen.dart';

class AppRoutes {
  static final routes = {
    '/': (context) => DialScreen(),
    '/history': (context) => HistoryScreen(),
  };
}
