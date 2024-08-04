import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import for date formatting
import '../models/event_model.dart';

class EventListScreen extends StatelessWidget {
  final String eventType;
  final List<Event> events;

  EventListScreen({required this.eventType, required this.events});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(eventType + ' Events'),
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return ListTile(
            leading: Image.asset(event.imageUrl),
            title: Text(event.title),
            subtitle: Text(
              '${event.venue}\n${DateFormat('dd MMM yyyy').format(event.date)}\n${event.highlights}',
              style: TextStyle(color: Colors.grey[700]),
            ),
            trailing: event.isBooked
                ? Icon(Icons.check_circle, color: Colors.green)
                : Icon(Icons.cancel, color: Colors.red),
          );
        },
      ),
    );
  }
}
