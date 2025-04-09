import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/annotations.dart';

// Gerar mocks para FirebaseAuth e FirebaseApp
@GenerateMocks([FirebaseAuth, FirebaseApp, UserCredential, User])
void main() {}
