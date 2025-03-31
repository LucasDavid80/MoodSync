import 'package:flutter/material.dart';
import 'package:mood_sync/screens/calendar/calendar_screen.dart';
import 'package:mood_sync/shared/constants/custom_colors.dart';

class DiaryScreen extends StatelessWidget {
  const DiaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'MoodSync',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: CustomColors().getAppBarMainColor(),
        ),
        body: Center(child: CalendarScreen()),
        drawer: Drawer(
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: CustomColors().getAppBarMainColor(),
                ),
                accountEmail: const Text('lucas@gmail.com'),
                accountName: const Text('Lucas David'),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    'LD',
                    style: TextStyle(
                      fontSize: 40,
                      color: CustomColors().getGradientMainColor(),
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: CustomColors().getGradientMainColor(),
                ),
                title: const Text('Configurações'),
              ),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  color: CustomColors().getGradientMainColor(),
                ),
                title: const Text('Sair'),
                onTap: () {
                  // ignore: avoid_print
                  print('Saiu');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
