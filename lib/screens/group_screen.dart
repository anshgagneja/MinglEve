import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GroupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Groups',
          style: GoogleFonts.lobster(),
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Center(
        child: Hero(
          tag: 'Groups',
          child: Material(
            color: Colors.transparent,
            child: Text(
              'Group Screen',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
