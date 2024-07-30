import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventDiscoveryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Discover Events',
          style: GoogleFonts.lobster(),
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Center(
        child: Hero(
          tag: 'Discover Events',
          child: Material(
            color: Colors.transparent,
            child: Text(
              'Event Discovery Screen',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
