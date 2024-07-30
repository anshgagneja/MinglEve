import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'event_list_screen.dart';
import '../models/event_model.dart';

class ProfileScreen extends StatelessWidget {
  final List<Event> upcomingEvents = [
    Event(
      title: 'Rave Party',
      imageUrl: 'assets/rave_party.jpg',
      venue: 'Country Inn, Manipal',
      expectedPopulation: '300+',
      entryFee: '₹499',
      highlights: 'Live DJ, Light Shows, Dance Floor, Unlimited Booze',
      isBooked: true, // Set this to true if the user has booked it
    ),
    Event(
      title: 'Sundowner',
      imageUrl: 'assets/sundowner.jpg',
      venue: 'Barrels, Manipal',
      expectedPopulation: '100+',
      entryFee: '₹799',
      highlights: 'Sunset Views, Cocktails, Live Music',
      isBooked: false, // Set this according to the booking status
    ),
  ];

  final List<Event> pastEvents = [
    Event(
      title: 'House Party',
      imageUrl: 'assets/house_party.jpg',
      venue: 'Tdi City, Moradabad',
      expectedPopulation: '50+',
      entryFee: '₹199',
      highlights: 'Casual Hangout, Music, Games',
      isBooked: true, // Assume this is booked
    ),
    Event(
      title: 'New Year\'s Eve',
      imageUrl: 'assets/rave_party.jpg',
      venue: 'Edge, Manipal',
      expectedPopulation: '200+',
      entryFee: '₹999',
      highlights: 'Celebrations, Music, Dance, Party Favors',
      isBooked: true, // Assume this is booked
    ),
    Event(
      title: 'Prom Night',
      imageUrl: 'assets/prom_night.jpg',
      venue: 'Country Inn, Manipal',
      expectedPopulation: '150+',
      entryFee: '₹799',
      highlights: 'Formal Dance, Dinner, Entertainment',
      isBooked: true, // Assume this is booked
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.lobster(),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage('assets/profile_pic.jpg'),
                    backgroundColor: Colors.grey[300],
                  ),
                  Positioned(
                    bottom: -10,
                    right: -10,
                    child: IconButton(
                      icon: Icon(Icons.edit, color: Colors.deepPurpleAccent),
                      onPressed: () {
                        // Add functionality to change profile picture
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'Ansh Gagneja',
                style: GoogleFonts.lobster(
                  fontSize: 24,
                  color: Colors.deepPurpleAccent,
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                'anshgagneja1614@gmail.com',
                style: GoogleFonts.openSans(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventListScreen(
                      eventType: 'Upcoming',
                      events: upcomingEvents,
                    ),
                  ),
                );
              },
              child: Text('Upcoming Events'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventListScreen(
                      eventType: 'Past',
                      events: pastEvents,
                    ),
                  ),
                );
              },
              child: Text('Past Events'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to settings screen or open settings dialog
              },
              child: Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
