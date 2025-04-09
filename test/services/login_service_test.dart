import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mood_sync/services/login_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../mocks/mock_firebase.mocks.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

void main() {
  late LoginService loginService;
  late MockFirebaseAuth mockFirebaseAuth;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    loginService = LoginService();
  });

  test('Deve retornar null ao fazer login com sucesso', () async {
    when(
      mockFirebaseAuth.signInWithEmailAndPassword(
        email: 'email',
        password: 'password',
      ),
    ).thenAnswer((_) async => MockUserCredential());

    final result = await loginService.loginUser(
      email: 'test@example.com',
      password: 'password123',
    );

    expect(result, isNull);
  });

  test('Deve retornar mensagem de erro ao falhar no login', () async {
    when(
      mockFirebaseAuth.signInWithEmailAndPassword(
        email: 'test@example.com',
        password: 'password123',
      ),
    ).thenThrow(FirebaseAuthException(code: 'user-not-found'));

    final result = await loginService.loginUser(
      email: 'test@example.com',
      password: 'password123',
    );

    expect(result, 'user-not-found');
  });

  test('Deve chamar signOut ao fazer logout', () async {
    await loginService.logoutUser();
    verify(mockFirebaseAuth.signOut()).called(1);
  });
}
