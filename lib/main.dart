import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postownik/aplication/core/router.dart';
import 'package:postownik/aplication/pages/setup_page/setup_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const FlexScheme usedScheme = FlexScheme.blueM3;
    return MaterialApp.router(
      title: 'Flutter Demo',
      localizationsDelegates: const [
        ...GlobalCupertinoLocalizations.delegates,
        GlobalMaterialLocalizations.delegate
      ],
      themeMode: ThemeMode.system,
      theme: ThemeData.from(
        useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepOrange, brightness: Brightness.light)),
      darkTheme: ThemeData.from(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepOrange)),
      routerConfig: routes,
    );
  }
}
