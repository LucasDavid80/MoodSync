import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mood_sync/screens/calendar/calendar_screen.dart';
import 'package:mood_sync/services/login_service.dart';
import 'package:mood_sync/shared/constants/custom_colors.dart';

class DiaryScreen extends StatefulWidget {
  final User user;
  const DiaryScreen({super.key, required this.user});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
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
                accountEmail: Text((widget.user.displayName ?? "")),
                accountName: Text(widget.user.email!),
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
                title: const Text('Configurações2'),
              ),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  color: CustomColors().getGradientMainColor(),
                ),
                title: const Text('Sair'),
                onTap: () {
                  LoginService().logoutUser();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
