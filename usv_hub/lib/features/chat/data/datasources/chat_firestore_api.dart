import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/core/errors/exceptions.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/chat/data/models/contact_model.dart';
import 'package:usv_hub/features/chat/data/models/mesaje_model.dart';
import 'package:usv_hub/features/chat/data/models/user_model.dart';

@LazySingleton()
class ChatFirestoreApi {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? _user = FirebaseAuth.instance.currentUser;

  Future<List<ContactModel>> getAllContacts() async {
    final List<ContactModel> contacts = [];

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
        QuerySnapshot<Map<String, dynamic>> result;
        if (doc[AppFields.person1] == _user.uid) {
          result = await _firestore
              .collection(AppCollections.teacher)
              .where(AppFields.id, isEqualTo: doc[AppFields.person2])
              .get();
          if (result.docs.isNotEmpty) {
            name = result.docs[0][AppFields.name];
          } else {
            result = await _firestore
                .collection(AppCollections.student)
                .where(AppFields.id, isEqualTo: doc[AppFields.person2])
                .get();
            name = result.docs[0][AppFields.name];
          }
        } else {
          result = await _firestore
              .collection(AppCollections.teacher)
              .where(AppFields.id, isEqualTo: doc[AppFields.person1])
              .get();
          if (result.docs.isNotEmpty) {
            name = result.docs[0][AppFields.name];
          } else {
            result = await _firestore
                .collection(AppCollections.student)
                .where(AppFields.id, isEqualTo: doc[AppFields.person1])
                .get();
            name = result.docs[0][AppFields.name];
          }
        }

        ContactModel contact = ContactModel.fromMap(doc.data(), name);
        contacts.add(contact);
      }
      return contacts;
    } on FirebaseException catch (e) {
      throw MediumException(runtimeType, e.message!);
    } catch (e) {
      throw MediumException(runtimeType, e.toString());
    }
  }

  // Functia pentru obtinerea stream-ului de mesaje
  Stream<List<MesajeModel>> getMessages(String contactId) {
    try {
      // Mesajele unde utilizatorul este expeditor (sender)
      final sentMessagesStream = _firestore
          .collection(AppCollections.message)
          .where(AppFields.contactId, isEqualTo: contactId)
          .snapshots()
          .map(
            (snapshot) => snapshot.docs
                .map((doc) => MesajeModel.fromJson(doc.data()))
                .toList(),
          );
      return sentMessagesStream;
    } on FirebaseException catch (e) {
      throw MediumException(runtimeType, e.message!);
    } catch (e) {
      throw MediumException(runtimeType, e.toString());
    }
  }

  Future<void> sendMesage(MesajeModel mesajeEntity) async {
    try {
      // Generate a new document reference with a unique ID
      final docRef = _firestore.collection(AppCollections.message).doc();

      // Update the MesajeModel with the generated document ID
      final updatedMessage = MesajeModel(
        id: docRef.id, // Set the generated ID here
        text: mesajeEntity.text,
        senderId: mesajeEntity.senderId,
        contactId: mesajeEntity.contactId,
        timeWhenSent: mesajeEntity.timeWhenSent,
      );

      // Save the message to Firestore using the generated ID
      await docRef.set(updatedMessage.toJson());
    } on FirebaseException catch (e) {
      throw MediumException(runtimeType, e.message!);
    } catch (e) {
      throw MediumException(runtimeType, e.toString());
    }
  }

  Future<List<UserModel>> getPotentialContacts(List<String> contacts) async {
    try {
      final response = await _firestore
          .collection(AppCollections.teacher)
          .where(AppFields.id, whereNotIn: contacts)
          .get()
          .then(
            (value) => value.docs
                .map((doc) => UserModel.fromJson(doc.data()))
                .toList(),
          );

      return response;
    } on FirebaseException catch (e) {
      throw MediumException(runtimeType, e.message!);
    } catch (e) {
      throw MediumException(runtimeType, e.toString());
    }
  }

  Future<void> createContact(ContactModel contacts) async {
    try {
      final docRef = _firestore.collection(AppCollections.contacts).doc();
      await docRef.set(contacts.copyWith(id: docRef.id).toMap());

      return;
    } on FirebaseException catch (e) {
      throw MediumException(runtimeType, e.message!);
    } catch (e) {
      throw MediumException(runtimeType, e.toString());
    }
  }
}
