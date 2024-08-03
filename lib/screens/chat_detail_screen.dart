// lib/screens/chat_detail_screen.dart

import 'package:flutter/material.dart';

class ChatDetailScreen extends StatelessWidget {
  final String contact;

  ChatDetailScreen({required this.contact});

  final List<Map<String, dynamic>> messages = [
    {'sender': 'They', 'message': 'Hi there!', 'isMe': false},
    {'sender': 'You', 'message': 'Hello!', 'isMe': true},
    {'sender': 'They', 'message': 'How are you doing?', 'isMe': false},
    {'sender': 'You', 'message': 'I\'m doing great, thanks!', 'isMe': true},
    {'sender': 'They', 'message': 'What are you up to?', 'isMe': false},
    {'sender': 'You', 'message': 'Just working on some projects.', 'isMe': true},
    {'sender': 'They', 'message': 'That sounds interesting!', 'isMe': false},
    {'sender': 'You', 'message': 'Yes, it is!', 'isMe': true},
    {'sender': 'They', 'message': 'Do you have any plans for the weekend?', 'isMe': false},
    {'sender': 'You', 'message': 'Not yet, maybe you have any suggestions?', 'isMe': true},
    {'sender': 'They', 'message': 'How about a movie night?', 'isMe': false},
    {'sender': 'You', 'message': 'That sounds perfect!', 'isMe': true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contact),
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return ChatMessage(
            sender: messages[index]['sender'],
            message: messages[index]['message'],
            isMe: messages[index]['isMe'],
          );
        },
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String sender;
  final String message;
  final bool isMe;

  ChatMessage({required this.sender, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(sender, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Container(
            decoration: BoxDecoration(
              color: isMe ? Colors.blue[100] : Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(10),
            child: Text(
              message,
              style: TextStyle(color: isMe ? Colors.black : Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
