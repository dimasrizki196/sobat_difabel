import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add user data to Firestore
  Future<void> addUser(String uid, String username, String email, String role) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        'username': username,
        'email': email,
        'role': role,
      });
    } catch (e) {
      print('Error adding user: $e');
    }
  }

  // Fetch all users
  Future<List<Map<String, dynamic>>> fetchUsers() async {
    try {
      final snapshot = await _firestore.collection('users').get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('Error fetching users: $e');
      return [];
    }
  }
}
