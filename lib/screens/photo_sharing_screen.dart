import 'package:flutter/material.dart';

class PhotoSharingScreen extends StatefulWidget {
  @override
  _PhotoSharingScreenState createState() => _PhotoSharingScreenState();
}

class _PhotoSharingScreenState extends State<PhotoSharingScreen> {
  // Replace with asset images for testing
  List<String> photoAssets = [
    'assets/photo1.jpg',
    'assets/photo2.jpg',
    // Add more asset paths
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Photos'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Number of photos per row
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: photoAssets.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // View photo in full screen
              _viewPhotoFullScreen(context, photoAssets[index]);
            },
            onLongPress: () {
              // Show options to delete photo
              _showPhotoOptions(context, index);
            },
            child: Image.asset(
              photoAssets[index],
              fit: BoxFit.cover,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle photo upload
          _uploadPhoto();
        },
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  void _viewPhotoFullScreen(BuildContext context, String photoAsset) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenPhotoView(photoAsset: photoAsset),
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
                // Handle photo deletion
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

  void _uploadPhoto() {
    // Implement photo upload functionality
  }

  void _deletePhoto(int index) {
    setState(() {
      photoAssets.removeAt(index);
    });
    Navigator.pop(context);
  }
}

class FullScreenPhotoView extends StatelessWidget {
  final String photoAsset;

  FullScreenPhotoView({required this.photoAsset});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Image.asset(photoAsset),
      ),
    );
  }
}
