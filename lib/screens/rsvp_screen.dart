import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/event_model.dart' as model_event;

class RSVP_Screen extends StatelessWidget {
  final List<model_event.Event> rsvpEvents;

  RSVP_Screen({required this.rsvpEvents});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My RSVPs',
          style: GoogleFonts.lobster(),
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: rsvpEvents.isEmpty
          ? Center(
              child: Text(
                'No RSVPs yet!',
                style: GoogleFonts.openSans(
                  fontSize: 20,
                  color: Colors.deepPurpleAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ListView.builder(
              itemCount: rsvpEvents.length,
              itemBuilder: (context, index) {
                final event = rsvpEvents[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: ListTile(
                    leading: Image.asset(event.imageUrl, fit: BoxFit.cover),
                    title: Text(
                      event.title,
                      style: GoogleFonts.openSans(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Venue: ${event.venue}'),
                        Text('Date: ${event.date.toLocal()}'),
                        Text('Expected Population: ${event.expectedPopulation}'),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
