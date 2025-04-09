import 'package:flutter_test/flutter_test.dart'; // Importa o pacote de testes do Flutter.
import 'package:mockito/mockito.dart'; // Importa o pacote Mockito para criar mocks.
// Importa o pacote Firebase Auth.
import 'mocks/mock_firebase.mocks.dart'; // Importa os mocks gerados para Firebase.

void main() {
  late MockFirebaseAuth
  mockFirebaseAuth; // Declaração tardia de um mock para FirebaseAuth.
  late MockUserCredential
  mockUserCredential; // Declaração tardia de um mock para UserCredential.

  // Configuração inicial antes de cada teste.
  setUp(() {
    // Inicializa o mock de FirebaseAuth.
    mockFirebaseAuth = MockFirebaseAuth();
    // Inicializa o mock de UserCredential.
    mockUserCredential = MockUserCredential();
  });

  test('Deve retornar um usuário falso ao fazer login', () async {
    // Define um teste que verifica o login falso.
    when(
      mockFirebaseAuth.signInWithEmailAndPassword(
        // Configura o comportamento do mock para o método signInWithEmailAndPassword.
        email: 'teste@teste.com', // Email usado no teste.
        password: '123456', // Senha usada no teste.
      ),
    ).thenAnswer(
      (_) async =>
          mockUserCredential, // Retorna o mock de UserCredential ao chamar o método.
    );

    final result = await mockFirebaseAuth.signInWithEmailAndPassword(
      // Chama o método simulado.
      email: 'teste@teste.com', // Email usado na chamada.
      password: '123456', // Senha usada na chamada.
    );

    expect(result, isNotNull); // Verifica se o resultado não é nulo.
  });
}
