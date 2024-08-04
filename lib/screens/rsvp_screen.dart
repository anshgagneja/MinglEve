import 'package:flutter/material.dart';
import '../models/event_model.dart' as model_event;

class RSVP_Screen extends StatelessWidget {
  final model_event.Event event;

  RSVP_Screen({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RSVP'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Venue: ${event.venue}'),
            Text('Date: ${event.date}'),  // Assuming date is part of the event model
            Text('Expected Population: ${event.expectedPopulation}'),
            Text('Entry Fee: ${event.entryFee}'),
            Text('Highlights: ${event.highlights}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle RSVP functionality here
              },
              child: Text('RSVP'),
            ),
          ],
        ),
      ),
    );
  }
}
