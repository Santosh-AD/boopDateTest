import 'package:flutter/material.dart';
import 'package:test_task/presentation/home/dashboard.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => DashboardView());
      default:
        return MaterialPageRoute(builder: (_) => DashboardView());
    }
  }
}
