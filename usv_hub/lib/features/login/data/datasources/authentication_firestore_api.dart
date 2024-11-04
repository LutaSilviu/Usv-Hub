import 'dart:developer';

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
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      log(userCredential.user!.uid);
      log(_firebaseAuth.currentUser!.uid);
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

  Future<Map<SelectedType, UserModel>> getUserModel() async {
    try {
      var response = await _firestore
          .collection(AppCollections.student)
          .doc(_firebaseAuth.currentUser!.uid)
          .get();
      if (response.data() != null) {
        return {SelectedType.student: UserModel.fromJson(response.data()!)};
      } else {
        response = await _firestore
            .collection(AppCollections.teacher)
            .doc(_firebaseAuth.currentUser!.uid)
            .get();
        return {SelectedType.teacher: UserModel.fromJson(response.data()!)};
      }
    } on FirebaseAuthException catch (e) {
      throw e.message!;
    }
  }
}
