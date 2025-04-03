import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mood_sync/main.dart';
import 'package:mood_sync/screens/diary_screen.dart';
import 'package:mood_sync/screens/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
// import 'main_test.mocks.dart';

@GenerateMocks([FirebaseAuth, User])
void main() {
  setUpAll(() async {
    // Inicializa o Firebase antes de executar os testes
    TestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  });

  testWidgets('Deve exibir a tela inicial RouterScreen', (
    WidgetTester tester,
  ) async {
    // Renderiza o widget principal
    await tester.pumpWidget(const MyApp());

    // Verifica se a tela inicial (RouterScreen) é exibida
    expect(find.byType(RouterScreen), findsOneWidget);
  });

  // group('RouterScreen', () {
  //   testWidgets('Deve exibir DiaryScreen quando o usuário está autenticado', (
  //     WidgetTester tester,
  //   ) async {
  //     // Mock do FirebaseAuth e User
  //     final mockAuth = MockFirebaseAuth();
  //     final mockUser = MockUser();
  //     when(mockAuth.userChanges()).thenAnswer((_) => Stream.value(mockUser));

  //     // Renderiza o RouterScreen
  //     await tester.pumpWidget(MaterialApp(home: RouterScreen()));

  //     // Verifica se DiaryScreen é exibido
  //     expect(find.byType(DiaryScreen), findsOneWidget);
  //   });

  //   testWidgets('Deve exibir LoginPage quando o usuário não está autenticado', (
  //     WidgetTester tester,
  //   ) async {
  //     // Mock do FirebaseAuth
  //     final mockAuth = MockFirebaseAuth();
  //     when(mockAuth.userChanges()).thenAnswer((_) => Stream.value(null));

  //     // Renderiza o RouterScreen
  //     await tester.pumpWidget(MaterialApp(home: RouterScreen()));

  //     // Verifica se LoginPage é exibido
  //     expect(find.byType(LoginPage), findsOneWidget);
  //   });
  // });

  // group('Testes gerais', () {
  //   test('Teste de exemplo', () {
  //     // Teste básico de exemplo
  //     expect(2 + 2, equals(4));
  //   });

  //   // Adicione outros testes relacionados ao MyApp ou rotas aqui
  // });
}
