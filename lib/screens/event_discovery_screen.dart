import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/event_model.dart' as model_event;
import 'booking_screen.dart';
import 'rsvp_screen.dart';
import 'event_detail_screen.dart';

class EventDiscoveryScreen extends StatefulWidget {
  @override
  _EventDiscoveryScreenState createState() => _EventDiscoveryScreenState();
}

class _EventDiscoveryScreenState extends State<EventDiscoveryScreen> {
  final List<model_event.Event> events = [
    model_event.Event(
      title: 'Rave Party',
      imageUrl: 'assets/rave_party.jpg',
      venue: 'Country Inn, Manipal',
      expectedPopulation: '300+',
      entryFee: '₹499',
      highlights: 'Live DJ, Light Shows, Dance Floor, Unlimited Booze',
      date: DateTime.now(), // Example, adjust as necessary
    ),
    model_event.Event(
      title: 'Pool Party',
      imageUrl: 'assets/pool_party.jpg',
      venue: 'Radisson Blu, New Delhi',
      expectedPopulation: '150+',
      entryFee: '₹599',
      highlights: 'Swimming, Pool Games, BBQ, Booze',
      date: DateTime.now(), // Example, adjust as necessary
    ),
    model_event.Event(
      title: 'Sundowner',
      imageUrl: 'assets/sundowner.jpg',
      venue: 'Barrels, Manipal',
      expectedPopulation: '100+',
      entryFee: '₹799',
      highlights: 'Sunset Views, Cocktails, Live Music',
      date: DateTime.now(), // Example, adjust as necessary
    ),
    model_event.Event(
      title: 'BYOB House Party',
      imageUrl: 'assets/house_party.jpg',
      venue: 'Pearl City 201, Manipal',
      expectedPopulation: '50+',
      entryFee: '₹199',
      highlights: 'Casual Hangout, Music, Games',
      date: DateTime.now(), // Example, adjust as necessary
    ),
  ];

  List<model_event.Event> rsvpEvents = [];

  void _navigateToBooking(BuildContext context, model_event.Event event) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookingScreen(event: event),
      ),
    );
  }

  void _toggleRSVP(model_event.Event event) {
    setState(() {
      if (rsvpEvents.contains(event)) {
        rsvpEvents.remove(event);
      } else {
        rsvpEvents.add(event);
      }
    });
  }

  bool _isRSVPd(model_event.Event event) {
    return rsvpEvents.contains(event);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Discover Events',
          style: GoogleFonts.lobster(),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Center(
              child: Image.asset(
                'assets/logo.png',
                height: 100,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Upcoming Events',
                style: GoogleFonts.openSans(
                  fontSize: 20,
                  color: Colors.deepPurpleAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Column(
              children: events.map((event) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventDetailsScreen(event: event),
                    ),
                  );
                },
                child: Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image.asset(event.imageUrl),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              event.title,
                              style: GoogleFonts.openSans(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('Venue: ${event.venue}'),
                            Text('Expected Population: ${event.expectedPopulation}'),
                            Text('Entry Fee: ${event.entryFee}'),
                            Text('Highlights: ${event.highlights}'),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () => _navigateToBooking(context, event),
                                  child: Text('Book Now'),
                                ),
                                ElevatedButton(
                                  onPressed: () => _toggleRSVP(event),
                                  child: Text(_isRSVPd(event) ? 'Cancel RSVP' : 'RSVP'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )).toList(),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RSVP_Screen(rsvpEvents: rsvpEvents),
                  ),
                );
              },
              child: Text('View My RSVPs'),
            ),
          ],
        ),
      ),
    );
  }
}
