import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method to sign in with email and password
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      // Attempt to sign in the user with email and password
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Return the authenticated user
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else if (e.code == 'invalid-email') {
        print('The email address is not valid.');
      } else {
        print('Error signing in: ${e.message}');
      }
      return null;
    } catch (e) {
      // Handle any other errors
      print('Error signing in: $e');
      return null;
    }
  }
}
