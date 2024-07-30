import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/event_model.dart'; 
import 'event_detail_screen.dart';

class EventListScreen extends StatelessWidget {
  final String eventType;
  final List<Event> events;

  EventListScreen({required this.eventType, required this.events});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$eventType Events',
          style: GoogleFonts.lobster(),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: ListTile(
              leading: Image.asset(event.imageUrl),
              title: Text(event.title),
              subtitle: Text(event.venue),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventDetailsScreen(
                      event: event,
                      // Remove isPastEvent parameter
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
