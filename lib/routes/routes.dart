import 'package:flutter/material.dart';
import 'package:inventory_app/pages/pages.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'home': (_) => HomePage(),
  'welcome': (_) => WelcomePage(),
  'login': (_) => LoginPage(),
};
