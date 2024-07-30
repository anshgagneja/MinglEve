import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PhotoSharingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Photo Sharing',
          style: GoogleFonts.lobster(),
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Center(
        child: Hero(
          tag: 'Photo Sharing',
          child: Material(
            color: Colors.transparent,
            child: Text(
              'Photo Sharing Screen',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
