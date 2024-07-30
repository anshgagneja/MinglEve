import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chat',
          style: GoogleFonts.lobster(),
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Center(
        child: Hero(
          tag: 'Chat',
          child: Material(
            color: Colors.transparent,
            child: Text(
              'Chat Screen',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
