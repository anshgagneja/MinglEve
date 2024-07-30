import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RSVP_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'RSVP',
          style: GoogleFonts.lobster(),
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Center(
        child: Hero(
          tag: 'RSVP',
          child: Material(
            color: Colors.transparent,
            child: Text(
              'RSVP Screen',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
