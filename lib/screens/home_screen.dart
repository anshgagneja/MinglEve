import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'auth_screen.dart';
import 'event_discovery_screen.dart';
import 'profile_screen.dart';
import 'rsvp_screen.dart';
import 'chat_screen.dart';
import 'group_screen.dart';
import 'photo_sharing_screen.dart';
import 'event_detail_screen.dart';
import 'booking_screen.dart';
import '../models/event_model.dart' as model_event;

class HomeScreen extends StatelessWidget {
  final List<String> imgList = [
    'assets/photo1.jpg',
    'assets/photo2.jpg',
    'assets/photo3.jpg',
  ];

  final List<model_event.Event> events = [
    model_event.Event(
      title: 'Rave Party',
      imageUrl: 'assets/rave_party.jpg',
      venue: 'Country Inn, Manipal',
      expectedPopulation: '300+',
      entryFee: '₹499',
      highlights: 'Live DJ, Light Shows, Dance Floor, Unlimited Booze',
    ),
    model_event.Event(
      title: 'Pool Party',
      imageUrl: 'assets/pool_party.jpg',
      venue: 'Radisson Blu, New Delhi',
      expectedPopulation: '150+',
      entryFee: '₹599',
      highlights: 'Swimming, Pool Games, BBQ, Booze',
    ),
    model_event.Event(
      title: 'Sundowner',
      imageUrl: 'assets/sundowner.jpg',
      venue: 'Barrels, Manipal',
      expectedPopulation: '100+',
      entryFee: '₹799',
      highlights: 'Sunset Views, Cocktails, Live Music',
    ),
    model_event.Event(
      title: 'BYOB House Party',
      imageUrl: 'assets/house_party.jpg',
      venue: 'Pearl City 201, Manipal',
      expectedPopulation: '50+',
      entryFee: '₹199',
      highlights: 'Casual Hangout, Music, Games',
    ),
  ];

  void _logout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AuthScreen()),
    );
  }

  void _navigateToBooking(BuildContext context, model_event.Event event) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookingScreen(event: event),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MinglEve',
          style: GoogleFonts.lobster(),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/logo.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(),
            ),
            DrawerItem(
              icon: Icons.event,
              text: 'Discover Events',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EventDiscoveryScreen()),
                );
              },
            ),
            DrawerItem(
              icon: Icons.person,
              text: 'Profile',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
            ),
            DrawerItem(
              icon: Icons.check_circle,
              text: 'RSVP',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RSVP_Screen()),
                );
              },
            ),
            DrawerItem(
              icon: Icons.chat,
              text: 'Chat',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatScreen()),
                );
              },
            ),
            DrawerItem(
              icon: Icons.group,
              text: 'Groups',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GroupScreen()),
                );
              },
            ),
            DrawerItem(
              icon: Icons.photo,
              text: 'Photo Sharing',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PhotoSharingScreen()),
                );
              },
            ),
            DrawerItem(
              icon: Icons.logout,
              text: 'Logout',
              onTap: () => _logout(context),
            ),
          ],
        ),
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
            Text(
              'Welcome to MinglEve!',
              style: GoogleFonts.lobster(
                fontSize: 28,
                color: Colors.deepPurpleAccent,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'MinglEve is your ultimate companion for discovering and attending exciting events, meeting new people, and sharing memorable moments. Explore the endless possibilities and start your journey with us!',
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
            ),
            SizedBox(height: 30),
            CarouselSlider(
              options: CarouselOptions(
                height: 250,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.8,
                aspectRatio: 2.0,
                autoPlayInterval: Duration(seconds: 3),
              ),
              items: imgList.map((item) => Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    item,
                    fit: BoxFit.contain,
                    width: 1000,
                  ),
                ),
              )).toList(),
            ),
            SizedBox(height: 30),
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
                            ElevatedButton(
                              onPressed: () => _navigateToBooking(context, event),
                              child: Text('Book Now'),
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
          ],
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  DrawerItem({required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepPurple),
      title: Text(text),
      onTap: () {
        Navigator.pop(context); 
        onTap();
      },
    );
  }
}
