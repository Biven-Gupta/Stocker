import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:task/views/splash.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AndroidInitializationSettings androidSettings = const AndroidInitializationSettings("@mipmap/ic_launcher");
  DarwinInitializationSettings iOSSettings =
      const DarwinInitializationSettings(requestAlertPermission: true, requestBadgePermission: true, requestCriticalPermission: true, requestSoundPermission: true);
  InitializationSettings initializationSettings = InitializationSettings(android: androidSettings, iOS: iOSSettings);

  bool? initialize = await notificationsPlugin.initialize(initializationSettings);

  log("Notification $initialize");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Colors.amber),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
