import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mood_sync/screens/calendar/calendar_screen.dart';
import 'package:mood_sync/screens/login/login_screen.dart';
import 'package:mood_sync/shared/constants/custom_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'screens/diary_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  initializeDateFormatting('pt_BR', null).then((_) {
    // Inicialização corrigida
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoodSync',
      // debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: CustomColors().getActivePrimaryButtonColor(),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => RouterScreen(),
        // '/diary': (context) => DiaryScreen(),
        '/calendar': (context) => CalendarScreen(),
      },
    );
  }
}

class RouterScreen extends StatelessWidget {
  const RouterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return DiaryScreen(user: snapshot.data!);
        } else {
          return LoginPage();
        }
      },
    );
  }
}
