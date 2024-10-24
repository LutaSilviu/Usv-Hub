import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/chat/data/models/user_model.dart';

@LazySingleton()
class AuthenticationFirestoreApi {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  Future<UserModel> getUserModel() async {
    try {
      final response = await _firestore
          .collection(AppCollections.student)
          .doc(_firebaseAuth.currentUser!.uid)
          .get();
      return UserModel.fromJson(response.data()!);
    } on FirebaseAuthException catch (e) {
      throw e.message!;
    }
  }
}
