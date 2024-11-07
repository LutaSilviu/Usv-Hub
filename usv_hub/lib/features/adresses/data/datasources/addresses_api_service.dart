import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/core/errors/exceptions.dart';
import 'package:usv_hub/core/utils/consts.dart';

@LazySingleton()
class AddressesApiService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instance;

  Future<List<Map<String, String>>> getAddresses() async {
    try {
      final userId = _firebaseAuth.currentUser!.uid;
      final List<Map<String, String>> addresses = [];
      final response = await _firebaseFirestore
          .collection(AppCollections.addresses)
          .where(AppFields.userId, isEqualTo: userId)
          .orderBy(AppFields.address)
          .get();

      for (final doc in response.docs) {
        addresses.add({
          AppFields.id: doc.id,
          AppFields.address: doc[AppFields.address],
        });
      }

      return addresses;
    } on FirebaseException catch (e) {
      throw MediumException(runtimeType, e.message!);
    } catch (e) {
      throw MediumException(runtimeType, e.toString());
    }
  }

  Future<Map<String, String>> postAddresses(String address) async {
    try {
      final userId = _firebaseAuth.currentUser!.uid;

      final docRef =
          _firebaseFirestore.collection(AppCollections.addresses).doc();

      final Map<String, String> map = {
        AppFields.id: docRef.id,
        AppFields.userId: userId,
        AppFields.address: address,
      };
      await docRef.set(map);

      return map;
    } on FirebaseException catch (e) {
      throw MediumException(runtimeType, e.message!);
    } catch (e) {
      throw MediumException(runtimeType, e.toString());
    }
  }

  Future<Map<String, String>> editAddresses(String id, String addresses) async {
    try {
      final docRef = await _firebaseFirestore
          .collection(AppCollections.addresses)
          .where(AppFields.id, isEqualTo: id)
          .get();
      final doc = docRef.docs.first.data();
      final Map<String, String> map = {
        AppFields.id: doc[AppFields.id],
        AppFields.userId: doc[AppFields.userId],
        AppFields.address: addresses,
      };
      await _firebaseFirestore
          .collection(AppCollections.addresses)
          .doc(id)
          .update(map);
      return map;
    } on FirebaseException catch (e) {
      throw MediumException(runtimeType, e.message!);
    } catch (e) {
      throw MediumException(runtimeType, e.toString());
    }
  }
}
