import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mood_sync/screens/calendar/calendar_screen.dart';
import 'package:mood_sync/screens/login/login_screen.dart';
import 'package:mood_sync/shared/constants/custom_colors.dart';

import 'screens/diary_screen.dart';

void main() {
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: CustomColors().getActivePrimaryButtonColor(),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/diary': (context) => const DiaryScreen(),
        '/calendar': (context) => CalendarScreen(),
      },
      // home: LoginPage(),
    );
  }
}
