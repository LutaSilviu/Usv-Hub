import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/core/errors/exceptions.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/events/data/models/event_model.dart';

@LazySingleton()
class EventServiceApi {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instance;

  Future<List<EventModel>> getEvents() async {
    try {
      List<EventModel> events = [];
      final semXStudDoc = await _firestore
          .collection(AppCollections.semesterXStudentCollection)
          .where(AppFields.studentId, isEqualTo: _firebaseAuth.currentUser!.uid)
          .where(AppFields.isActive, isEqualTo: true)
          .limit(1)
          .get();
      final semesterId = semXStudDoc.docs.first.get(AppFields.semesterId);

      final semester = await _firestore
          .collection(AppCollections.semesterCollection)
          .where(AppFields.id, isEqualTo: semesterId)
          .get();

      final departamentId = semester.docs.first.get(AppFields.departamentId);

      final eventsDoc = await _firestore
          .collection(AppCollections.events)
          .where(AppFields.departamentId, isEqualTo: departamentId)
          .get();

      for (final doc in eventsDoc.docs) {
        events.add(EventModel.fromMap(doc.data()));
      }

      return events;
    } on FirebaseException catch (e) {
      throw MediumException(runtimeType, e.message!);
    }
  }
}
