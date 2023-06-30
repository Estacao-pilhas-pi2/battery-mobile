import 'package:estacao_pilhas/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'globals/colors.dart';
import 'pages/login/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  NotificationService notificationService = NotificationService();
  FirebaseService firebaseService = FirebaseService(notificationService);
  await firebaseService.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Estação Pilhas',
        theme: AppColors.appTheme,
        home: const Login());
  }
}
