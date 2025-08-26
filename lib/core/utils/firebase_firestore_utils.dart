import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/models/event_data.dart';

abstract class FirebaseFirestoreUtils {
  static CollectionReference<EventData> _getCollectionReference() {
    return FirebaseFirestore.instance
        .collection(EventData.collectionName)
        .withConverter<EventData>(
          fromFirestore:
              (snapshot, _) => EventData.fromFireStore(snapshot.data()!),
          toFirestore: (value, _) => value.toFireStore(),
        );
  }

  static Future<bool> createNewEventTask(EventData eventData) {
    try {
      var collectionReference = _getCollectionReference();
      var documentReference = collectionReference.doc();
      eventData.eventId = documentReference.id;
      documentReference.set(eventData);
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }

  static Future<List<EventData>> getEventTasksList() async {
    var collectionReference = _getCollectionReference();
    var dataCollection = await collectionReference.get();

    return dataCollection.docs.map((data) {
      return data.data();
    }).toList();
  }

  static Stream<QuerySnapshot<EventData>> getStreamEventTasksList({
    required String categoryId,
  }) {
    var collectionReference = _getCollectionReference().where(
      "eventCategoryId",
      isEqualTo: categoryId,
    );
    return collectionReference.snapshots();
  }
  static Stream<QuerySnapshot<EventData>> getStreamFavoriteEventTasksList() {
    var collectionReference = _getCollectionReference().where(
      "isFavorite",
      isEqualTo: true,
    );
    return collectionReference.snapshots();
  }

  static Future<void> updateEventTask({required EventData eventData}) {
    var collectionRef = _getCollectionReference();
    var docRef = collectionRef.doc(eventData.eventId);
    return docRef.update(eventData.toFireStore());
  }
  static Future<void> deleteEventTask({required EventData eventData}) {
    var collectionRef = _getCollectionReference();
    var docRef = collectionRef.doc(eventData.eventId);
    return docRef.delete();
  }
}
