import 'package:flutter/material.dart';
import 'package:mingleve/services/firestore_service.dart'; 

class RSVP_Screen extends StatefulWidget {
  @override
  _RSVP_ScreenState createState() => _RSVP_ScreenState();
}

class _RSVP_ScreenState extends State<RSVP_Screen> {
  final String eventId = 'some_event_id'; // Replace with actual event ID
  final String eventTitle = 'Sample Event'; // Replace with actual event title
  final FirestoreService _firestoreService = FirestoreService();

  void _rsvp() async {
    await _firestoreService.addRSVP(eventId, eventTitle);
    // Handle UI changes or show a message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('RSVP added for $eventTitle')),
    );
  }

  void _cancelRSVP() async {
    await _firestoreService.removeRSVP(eventId);
    // Handle UI changes or show a message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('RSVP canceled for $eventTitle')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('RSVP')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _rsvp,
              child: Text('RSVP'),
            ),
            ElevatedButton(
              onPressed: _cancelRSVP,
              child: Text('Cancel RSVP'),
            ),
          ],
        ),
      ),
    );
  }
}
