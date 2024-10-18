import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
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

  // Stream<MesajeModel> getAllMessages(String id) async* {
  //   final List<MesajeModel> messages = [];

  //   try {
  //     final response1 = await _firestore
  //         .collection(AppCollections.message)
  //         .where(AppFields.senderId, isEqualTo: _user!.uid )
  //         .where(AppFields.reciverId, isEqualTo: id)
  //         .get();

  //     final response2 = await _firestore
  //         .collection(AppCollections.message)
  //         .where(AppFields.reciverId, isEqualTo: _user.uid)
  //         .where(AppFields.senderId, isEqualTo: id)
  //         .get();

  //     final response = [...response1.docs, ...response2.docs];

  //     for (final doc in response) {
  //       MesajeModel message = MesajeModel.fromJson(doc.data());
  //       messages.add(message);
  //     }
  //     messages.sort((a, b) => a.timeWhenSent.compareTo(b.timeWhenSent));
  //     yield messages;
  //   } on FirebaseException catch (e) {
  //     throw MediumException(runtimeType, e.message!);
  //   } catch (e) {
  //     throw MediumException(runtimeType, e.toString());
  //   }
  // }

  // Functia pentru obtinerea stream-ului de mesaje
  Stream<List<MesajeModel>> getMessages(String id) {
    // Mesajele unde utilizatorul este expeditor (sender)
    Stream<List<MesajeModel>> sentMessagesStream = _firestore
        .collectionGroup(AppCollections.message)
        .where(AppFields.senderId, isEqualTo: _user!.uid)
        .where(AppFields.reciverId, isEqualTo: id)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => MesajeModel.fromJson(doc.data()))
          .toList();
    });

    // Mesajele unde utilizatorul este destinatar (receiver)
    Stream<List<MesajeModel>> receivedMessagesStream = _firestore
        .collectionGroup(AppCollections.message)
        .where(AppFields.reciverId, isEqualTo: _user.uid)
        .where(AppFields.senderId, isEqualTo: id)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => MesajeModel.fromJson(doc.data()))
          .toList();
    });

    // Combinam cele doua stream-uri intr-unul singur
    return Rx.combineLatest2(
      sentMessagesStream,
      receivedMessagesStream,
      (List<MesajeModel> sentMessages, List<MesajeModel> receivedMessages) {
        // Combina mesajele trimise și cele primite într-o singură listă
        return [...sentMessages, ...receivedMessages];
      },
    );
  }

  Future<void> sendMesage(MesajeModel mesajeEntity) async {
    try {
      // Generate a new document reference with a unique ID
      final docRef = _firestore.collection(AppCollections.message).doc();

      // Update the MesajeModel with the generated document ID
      final updatedMessage = MesajeModel(
        id: docRef.id, // Set the generated ID here
        messaje: mesajeEntity.messaje,
        senderId: mesajeEntity.senderId,
        reciverId: mesajeEntity.reciverId,
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
}
