import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:inventory_app/routes/routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      routes: appRoutes,
      initialRoute: 'login',
    );
  }
}
