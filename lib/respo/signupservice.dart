
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addUser(String name, String email, String password) async {
    try {
      await _db.collection('users').add({
        'name': name,
        'email': email,
        'password': password,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error adding user: $e');
    }
  }
}
