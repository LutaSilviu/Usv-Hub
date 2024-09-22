import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class AuthenticationFirestoreApi {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> login({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw e.message!;
    }
  }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw e.message!;
    }
  }

  Future<bool> isLoggedIn() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }
}
