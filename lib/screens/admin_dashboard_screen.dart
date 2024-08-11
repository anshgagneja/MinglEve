import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminDashboardScreen extends StatefulWidget {
  @override
  _AdminDashboardScreenState createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int totalEvents = 0;
  int totalRSVPs = 0;

  @override
  void initState() {
    super.initState();
    fetchAnalyticsData();
  }

  // Method to fetch analytics data from Firestore
  void fetchAnalyticsData() async {
    try {
      // Fetch total events
      QuerySnapshot eventSnapshot = await FirebaseFirestore.instance.collection('events').get();
      setState(() {
        totalEvents = eventSnapshot.docs.length;
      });

      // Fetch total RSVPs
      int rsvpCount = 0;
      for (var doc in eventSnapshot.docs) {
        rsvpCount += (doc['rsvpCount'] ?? 0) as int;
      }
      setState(() {
        totalRSVPs = rsvpCount;
      });

      // Future: Fetch and calculate user engagement data
    } catch (e) {
      print('Error fetching analytics data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Analytics Overview',
              style: Theme.of(context).textTheme.titleLarge, // Updated here
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                _buildMetricCard('Total Events', totalEvents),
                SizedBox(width: 16.0),
                _buildMetricCard('Total RSVPs', totalRSVPs),
              ],
            ),
            SizedBox(height: 16.0),
            _buildUserEngagementChart(),
          ],
        ),
      ),
    );
  }

  // Widget to build each metric card
  Widget _buildMetricCard(String title, int value) {
    return Expanded(
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Text(
                value.toString(),
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Placeholder for a user engagement chart (to be implemented)
  Widget _buildUserEngagementChart() {
    return Card(
      elevation: 4,
      child: Container(
        height: 200,
        child: Center(
          child: Text('User Engagement Chart (Coming Soon)'),
        ),
      ),
    );
  }
}
