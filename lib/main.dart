import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';
import 'screens/auth_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/event_list_screen.dart';
import 'screens/sign_up_screen.dart';
import 'screens/settings_screen.dart';
import '../models/event_model.dart'; // Import your Event model

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase for web and other platforms
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyB3VQ515XjVlZbgt9hx3vf5Py0Q_zfUqHo",
        authDomain: "mingleve.firebaseapp.com",
        projectId: "mingleve",
        storageBucket: "mingleve.appspot.com",
        messagingSenderId: "819685024679",
        appId: "1:819685024679:web:bac3cc51a32f097b194c82",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  
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
        date: DateTime(2024, 8, 10),
      ),
      Event(
        title: 'Sundowner',
        imageUrl: 'assets/sundowner.jpg',
        venue: 'Rooftop Lounge',
        expectedPopulation: '300',
        entryFee: '₹800',
        highlights: 'Sunset, Music, Drinks',
        date: DateTime(2024, 8, 15),
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
        '/signUp': (context) => SignUpScreen(), // Route to the SignUpScreen
      },
    );
  }
}
