import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/core/errors/exceptions.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/chat/data/models/mesaje_model.dart';
import 'package:usv_hub/features/chat/domain/entities/contact_entity.dart';

@LazySingleton()
class ChatFirestoreApi {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? _user = FirebaseAuth.instance.currentUser;

  Future<List<ContactEntity>> getAllContacts() async {
    final List<ContactEntity> contacts = [];

    try {
      final response1 = await _firestore
          .collection(AppCollections.contacts)
          .where(AppFields.status, isEqualTo: ContactsStatus.active.stringValue)
          .where(AppFields.person1, isEqualTo: _user!.uid)
          .get();
      final response2 = await _firestore
          .collection(AppCollections.contacts)
          .where(AppFields.status, isEqualTo: ContactsStatus.active.stringValue)
          .where(AppFields.person2, isEqualTo: _user.uid)
          .get();

      final response = [...response1.docs, ...response2.docs];

      for (final doc in response) {
        String name;
        if (doc[AppFields.person1] == _user.uid) {
          name = await _firestore
              .collection(AppCollections.teacher)
              .where(AppFields.id, isEqualTo: doc[AppFields.person2])
              .get()
              .then((value) => value.docs[0][AppFields.name]);
        } else {
          name = await _firestore
              .collection(AppCollections.teacher)
              .where(AppFields.id, isEqualTo: doc[AppFields.person1])
              .get()
              .then((value) => value.docs[0][AppFields.name]);
        }
        ContactEntity contact = ContactEntity(
          contactName: name,
          person1: doc[AppFields.person1],
          person2: doc[AppFields.person2],
          status: doc[AppFields.status].toContactsStatus()!,
        );
        contacts.add(contact);
      }
      return contacts;
    } on FirebaseException catch (e) {
      throw MediumException(runtimeType, e.message!);
    } catch (e) {
      throw MediumException(runtimeType, e.toString());
    }
  }

  Future<List<MesajeModel>> getAllMessages(String id) async {
    final List<MesajeModel> messages = [];

    try {
      final response1 = await _firestore
          .collection(AppCollections.message)
          .where(AppFields.senderId, isEqualTo: _user!.uid)
          .where(AppFields.reciverId, isEqualTo: id)
          .get();

      final response2 = await _firestore
          .collection(AppCollections.message)
          .where(AppFields.reciverId, isEqualTo: _user.uid)
          .where(AppFields.senderId, isEqualTo: id)
          .get();

      final response = [...response1.docs, ...response2.docs];

      for (final doc in response) {
        MesajeModel message = MesajeModel.fromJson(doc.data());
        messages.add(message);
      }
      messages.sort((a, b) => a.timeWhenSent.compareTo(b.timeWhenSent));
      return messages;
    } on FirebaseException catch (e) {
      throw MediumException(runtimeType, e.message!);
    } catch (e) {
      throw MediumException(runtimeType, e.toString());
    }
  }

  Future<void> sendMesage(MesajeModel mesajeEntity) async {
    try {
      await _firestore
          .collection(AppCollections.message)
          .add(mesajeEntity.toJson());
    } on FirebaseException catch (e) {
      throw MediumException(runtimeType, e.message!);
    } catch (e) {
      throw MediumException(runtimeType, e.toString());
    }
  }
}
