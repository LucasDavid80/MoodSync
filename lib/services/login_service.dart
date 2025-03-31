import 'package:firebase_auth/firebase_auth.dart';

class LoginService {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<String?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return null;
    } on FirebaseAuthException catch (e) {
      print('Error: $e');
      return e.message;
    }
  }

  Future<void> logoutUser() async {
    return _firebaseAuth.signOut();
  }
}
