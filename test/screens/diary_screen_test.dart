import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mood_sync/screens/diary_screen.dart';
import 'package:mood_sync/models/user_model.dart';

void main() {
  late UserModel mockUserModel;

  setUp(() {
    mockUserModel = UserModel(
      name: 'Test User',
      email: 'test@example.com',
      id: '1',
    );
  });

  testWidgets('Deve exibir o AppBar e o Drawer na DiaryScreen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: DiaryScreen(user: mockUserModel)),
    );

    // Verifica se o AppBar é exibido.
    expect(find.text('MoodSync'), findsOneWidget);

    // Simula a abertura do Drawer.
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    // Verifica se o Drawer é exibido.
    expect(find.byType(Drawer), findsOneWidget);
  });

  testWidgets('Deve exibir o nome e email do usuário no Drawer', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: DiaryScreen(user: mockUserModel)),
    );

    // Simula a abertura do Drawer.
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    // Verifica se o nome e email do usuário são exibidos.
    expect(find.text('Test User'), findsOneWidget);
    expect(find.text('test@example.com'), findsOneWidget);
  });
}
