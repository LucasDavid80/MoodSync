import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mood_sync/services/sing_up_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../mocks/mock_firebase.mocks.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

void main() {
  late SignUpService signUpService;
  late MockFirebaseAuth mockFirebaseAuth;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    signUpService = SignUpService();
  });

  test('Deve retornar null ao registrar usuário com sucesso', () async {
    when(
      mockFirebaseAuth.createUserWithEmailAndPassword(
        email: 'test@example.com',
        password: 'password123',
      ),
    ).thenAnswer((_) async => MockUserCredential());

    final result = await signUpService.registerUser(
      name: 'Test User',
      email: 'test@example.com',
      password: 'password123',
    );

    expect(result, isNull);
  });

  test('Deve retornar mensagem de erro ao falhar no registro', () async {
    when(
      mockFirebaseAuth.createUserWithEmailAndPassword(
        email: 'test@example.com',
        password: 'password123',
      ),
    ).thenThrow(FirebaseAuthException(code: 'email-already-in-use'));

    final result = await signUpService.registerUser(
      name: 'Test User',
      email: 'test@example.com',
      password: 'password123',
    );

    expect(result, 'Esse email já está em uso.');
  });
}
