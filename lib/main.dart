import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasbeeh_counter/core/Service/SettingsService.dart';
import 'package:tasbeeh_counter/core/theme/app_theme.dart';

import 'core/Service/stats_service.dart';
import 'home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final stats = StatsService();
  await stats.init();

  final settings = SettingsService();
  await settings.load();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider.value(value: stats),
      ChangeNotifierProvider.value(value: settings),
    ],
        child: const MyApp(),

    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final setteing = context.watch<SettingsService>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: homeScreen.routeName,
      routes: {
        homeScreen.routeName: (context) => const homeScreen(),
      },
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,

      themeMode: setteing.themeMode,

    );
  }
}

