import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PhotoSharingScreen extends StatefulWidget {
  @override
  _PhotoSharingScreenState createState() => _PhotoSharingScreenState();
}

class _PhotoSharingScreenState extends State<PhotoSharingScreen> {
  List<String> photoUrls = []; // Initialize with empty list or load from Firestore

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadPhotos();
  }

  Future<void> _loadPhotos() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('photos').orderBy('timestamp', descending: true).get();
      setState(() {
        photoUrls = snapshot.docs.map((doc) => doc['url'] as String).toList();
      });
    } catch (e) {
      print('Error loading photos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Photos'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: photoUrls.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _viewPhotoFullScreen(context, photoUrls[index]);
            },
            onLongPress: () {
              _showPhotoOptions(context, index);
            },
            child: Image.network(
              photoUrls[index],
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.error);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _uploadPhoto,
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  Future<void> _uploadPhoto() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      try {
        // Upload to Firebase Storage
        final Reference storageRef = FirebaseStorage.instance.ref().child('event_photos/$fileName');
        await storageRef.putFile(imageFile);

        // Get download URL
        String downloadUrl = await storageRef.getDownloadURL();

        // Save to Firestore
        await FirebaseFirestore.instance.collection('photos').add({
          'url': downloadUrl,
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Reload photos to update the UI
        _loadPhotos();
      } catch (e) {
        print('Error uploading photo: $e');
      }
    }
  }

  void _viewPhotoFullScreen(BuildContext context, String photoUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenPhotoView(photoUrl: photoUrl),
      ),
    );
  }

  void _showPhotoOptions(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('Delete Photo'),
              onTap: () {
                _deletePhoto(index);
              },
            ),
            ListTile(
              leading: Icon(Icons.cancel),
              title: Text('Cancel'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _deletePhoto(int index) async {
    try {
      // Delete from Firebase Storage
      String photoUrl = photoUrls[index];
      Reference photoRef = FirebaseStorage.instance.refFromURL(photoUrl);
      await photoRef.delete();

      // Delete from Firestore
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('photos').where('url', isEqualTo: photoUrl).get();
      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }

      setState(() {
        photoUrls.removeAt(index);
      });
    } catch (e) {
      print('Error deleting photo: $e');
    }
  }
}

class FullScreenPhotoView extends StatelessWidget {
  final String photoUrl;

  FullScreenPhotoView({required this.photoUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Image.network(photoUrl),
      ),
    );
  }
}
