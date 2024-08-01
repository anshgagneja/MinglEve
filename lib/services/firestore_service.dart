import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add RSVP to Firestore
  Future<void> addRSVP(String eventId, String eventTitle) async {
    final user = _auth.currentUser;

    if (user != null) {
      try {
        await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('rsvps')
            .doc(eventId) // Unique identifier for each RSVP
            .set({
              'eventId': eventId,
              'eventTitle': eventTitle,
              'timestamp': Timestamp.now(),
            });
      } catch (e) {
        print('Error adding RSVP: $e');
      }
    }
  }

  // Remove RSVP from Firestore
  Future<void> removeRSVP(String eventId) async {
    final user = _auth.currentUser;

    if (user != null) {
      try {
        await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('rsvps')
            .doc(eventId) // Unique identifier for each RSVP
            .delete();
      } catch (e) {
        print('Error removing RSVP: $e');
      }
    }
  }

  // Check if user has RSVP'd to a specific event
  Future<bool> hasRSVP(String eventId) async {
    final user = _auth.currentUser;

    if (user != null) {
      try {
        final doc = await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('rsvps')
            .doc(eventId)
            .get();

        return doc.exists;
      } catch (e) {
        print('Error checking RSVP status: $e');
        return false;
      }
    }
    return false;
  }

  // Fetch all RSVPs for a specific user
  Future<List<Map<String, dynamic>>> getUserRSVPs() async {
    final user = _auth.currentUser;

    if (user != null) {
      try {
        final snapshot = await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('rsvps')
            .get();

        return snapshot.docs.map((doc) => doc.data()).toList();
      } catch (e) {
        print('Error fetching RSVPs: $e');
        return [];
      }
    }
    return [];
  }

  // Add an event to Firestore
  Future<void> addEvent({
    required String eventId,
    required String title,
    required String imageUrl,
    required String venue,
    required String expectedPopulation,
    required String entryFee,
    required String highlights,
    required DateTime date,
  }) async {
    try {
      await _firestore.collection('events').doc(eventId).set({
        'title': title,
        'imageUrl': imageUrl,
        'venue': venue,
        'expectedPopulation': expectedPopulation,
        'entryFee': entryFee,
        'highlights': highlights,
        'date': Timestamp.fromDate(date),
      });
    } catch (e) {
      print('Error adding event: $e');
    }
  }
}
