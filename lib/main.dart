import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:inventory_app/providers/card_inventory_provider.dart';
import 'package:inventory_app/routes/routes.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(
    fileName: "assets/.env",
  ); // mergeWith optional, you can include Platform.environment for Mobile/Desktop app

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CardInventoryProvider()),
      ],
      child: MaterialApp(
        title: 'Material App',
        routes: appRoutes,
        initialRoute: 'home',
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
