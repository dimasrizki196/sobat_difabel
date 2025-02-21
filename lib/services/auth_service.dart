import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Register user
  Future<User?> registerUser(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      print('Registration error: $e');
      return null;
    }
  }

  // Login user
  Future<User?> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Login error: ${e.toString()}'); // Perbaiki logging
      return null;
    }
  }

  // Logout user
  Future<void> logoutUser() async {
    await _auth.signOut();
  }

  // Check current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
