import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';
import 'screens/auth_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/event_list_screen.dart';
import 'screens/settings_screen.dart';
import '../models/event_model.dart'; // Import your Event model

void main() {
  runApp(MinglEveApp());
}

class MinglEveApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Dummy event data for demonstration
    final List<Event> dummyEvents = [
      Event(
        title: 'Rave Party',
        imageUrl: 'assets/rave_party.jpg',
        venue: 'Downtown Club',
        expectedPopulation: '500',
        entryFee: '₹1000',
        highlights: 'Music, Dance, Lights',
      ),
      Event(
        title: 'Sundowner',
        imageUrl: 'assets/sundowner.jpg',
        venue: 'Rooftop Lounge',
        expectedPopulation: '300',
        entryFee: '₹800',
        highlights: 'Sunset, Music, Drinks',
      ),
      // Add more dummy events as needed
    ];

    return MaterialApp(
      title: 'MinglEve',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
        colorScheme: ColorScheme.dark(
          primary: Colors.deepPurple,
          secondary: Colors.purpleAccent,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Color(0xFF121212),
        textTheme: TextTheme(
          bodyLarge: GoogleFonts.lato(
            textStyle: TextStyle(color: Colors.white),
          ),
          bodyMedium: GoogleFonts.lato(
            textStyle: TextStyle(color: Colors.white70),
          ),
        ),
      ),
      home: AuthScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/profile': (context) => ProfileScreen(),
        '/events': (context) => EventListScreen(
          eventType: 'Upcoming',
          events: dummyEvents, // Pass dummy data here
        ),
        '/settings': (context) => SettingsScreen(),
      },
    );
  }
}
