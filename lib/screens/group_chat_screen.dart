import 'package:flutter/material.dart';
import 'group_screen.dart';

class GroupChatScreen extends StatelessWidget {
  final Group group;

  GroupChatScreen({required this.group});

  final String currentUser = 'Ansh'; // Replace with dynamic user identification if needed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(group.name),
      ),
      body: ListView(
        children: [
          ChatMessage(text: 'Who\'s coming this weekend?', sender: 'Ansh', timestamp: '10:00 AM', isCurrentUser: true),
          ChatMessage(text: 'Count me in!', sender: 'Alish', timestamp: '10:02 AM', isCurrentUser: false),
          ChatMessage(text: 'I\'ll be there too!', sender: 'Anoushka', timestamp: '10:05 AM', isCurrentUser: false),
          ChatMessage(text: 'Can\'t wait to see you all!', sender: 'Swapnil', timestamp: '10:10 AM', isCurrentUser: false),
          // Add more dummy messages as needed
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final String sender;
  final String timestamp;
  final bool isCurrentUser;

  ChatMessage({required this.text, required this.sender, required this.timestamp, required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isCurrentUser ? Colors.blue[700] : Colors.grey[700],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(isCurrentUser ? 'You' : sender, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            SizedBox(height: 5),
            Text(text, style: TextStyle(color: Colors.white)),
            SizedBox(height: 5),
            Text(timestamp, style: TextStyle(fontSize: 10, color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}
