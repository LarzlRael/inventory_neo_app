import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:inventory_app/providers/providers.dart';
import 'package:inventory_app/routes/app_router.dart';
import 'package:inventory_app/utils/utils.dart';
import 'package:provider/provider.dart';

import 'constants/constants.dart';
import 'env/environment_variables.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences.init();
  await Environment.initEnviroment();
  // mergeWith optional, you can include Platform.environment for Mobile/Desktop app
  runApp(ChangeNotifierProvider(
      create: (_) => ThemeProviderNotifier(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.watch<ThemeProviderNotifier>().appTheme;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CardInventoryProvider()),
        ChangeNotifierProvider(create: (_) => CategoriesMaterialProviders()),
        ChangeNotifierProvider(create: (_) => GlobalProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => ClientsProvider()),
        /* ChangeNotifierProvider(create: (_) => ProductsProvider()), */
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProxyProvider<ProductProvider, ProductsProvider>(
          create: (_) => ProductsProvider(),
          update: (_, productProvider, productsProvider) {
            productsProvider!.update(productProvider);
            return productsProvider;
          },
        )
      ],
      child: MaterialApp.router(
        title: appName,
        theme: appTheme.getTheme(),
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: formBuildersDelegates,
        supportedLocales: const [
          ...FormBuilderLocalizations.supportedLocales,
        ],
      ),
    );
  }
}
