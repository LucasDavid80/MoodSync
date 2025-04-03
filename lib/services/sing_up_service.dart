import 'package:firebase_auth/firebase_auth.dart';

class SignUpService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<String?> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      await userCredential.user!.updateDisplayName(name);

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'Esse email já está em uso.';
      } else if (e.code == 'weak-password') {
        return 'A senha deve ter pelo menos 6 caracteres.';
      } else if (e.code == 'invalid-email') {
        return 'Email inválido.';
      } else if (e.code == 'operation-not-allowed') {
        return 'Operação não permitida.';
      } else {
        return 'Erro desconhecido: ${e.message}';
      }
    }
  }
}
