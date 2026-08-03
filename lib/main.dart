import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/app.dart';
import 'features/notifications/notification_service.dart';
import 'features/notifications/notification_state.dart';
import 'features/theme/theme_state.dart';
import 'features/weather/weather_state.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => WeatherState(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeState(),
        ),
        ChangeNotifierProvider(
          create: (_) => NotificationState(),
        ),
      ],
      child: const WeatherApp(),
    ),
  );
}
