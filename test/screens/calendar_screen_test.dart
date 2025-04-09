import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mood_sync/models/user_model.dart';
import 'package:mood_sync/screens/calendar/calendar_screen.dart';
import 'package:table_calendar/table_calendar.dart';

import '../mocks/mock_firebase.mocks.dart';

void main() {
  late UserModel mockUserModel;
  late User mockUser;
  late MockUserCredential mockUserCredential;

  setUp(() {
    // Inicializa o mock de FirebaseAuth.
    // mockFirebaseAuth = MockFirebaseAuth();
    // Inicializa o mock de UserCredential.
    mockUserCredential = MockUserCredential();
  });

  testWidgets('Deve renderizar os widgets principais da CalendarScreen', (
    WidgetTester tester,
  ) async {
    // Renderiza a CalendarScreen.
    await tester.pumpWidget(MaterialApp(home: CalendarScreen(user: mockUser)));

    // Verifica se o TableCalendar é exibido.
    expect(find.byType(TableCalendar), findsOneWidget);

    // Verifica se o botão flutuante é exibido.
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });

  testWidgets('Deve abrir o diálogo ao clicar no botão flutuante', (
    WidgetTester tester,
  ) async {
    // Renderiza a CalendarScreen.
    await tester.pumpWidget(MaterialApp(home: CalendarScreen(user: mockUser)));

    // Clica no botão flutuante.
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    // Verifica se o diálogo foi exibido.
    expect(find.byType(AlertDialog), findsOneWidget);
  });

  testWidgets('Deve exibir eventos na data selecionada', (
    WidgetTester tester,
  ) async {
    // Renderiza a CalendarScreen.
    await tester.pumpWidget(MaterialApp(home: CalendarScreen(user: mockUser)));

    // Simula o clique no botão flutuante para abrir o diálogo.
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    debugPrint('Botão flutuante clicado e diálogo aberto.');

    // Preenche os campos do diálogo.
    await tester.enterText(find.byType(TextField).first, 'Feliz');
    await tester.enterText(find.byType(TextField).last, 'Dia incrível!');
    debugPrint('Campos do diálogo preenchidos.');

    // Confirma a adição do evento.
    await tester.tap(find.text('Adicionar'));
    await tester.pumpAndSettle();
    debugPrint('Evento adicionado.');

    // Verifica se o evento é exibido na lista.
    expect(find.text('Emoção do dia:   Feliz'), findsOneWidget);
    debugPrint('Texto "Emoção do dia:   Feliz" encontrado.');

    expect(find.text('Descrição:   Dia incrível!'), findsOneWidget);
    debugPrint('Texto "Descrição:   Dia incrível!" encontrado.');
  });
}
