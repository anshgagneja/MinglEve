// lib/screens/chat_screen.dart

import 'package:flutter/material.dart';
import 'chat_detail_screen.dart';

class ChatScreen extends StatelessWidget {
  final List<String> contacts = [
    'Ayushi',
    'Gracy',
    'Anoushka',
    'Swapnil',
    'Mohini',
    'Alish',
    'Vansh',
    'Abhay',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              child: Text(contacts[index][0]),
            ),
            title: Text(contacts[index]),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ChatDetailScreen(contact: contacts[index]),
              ));
            },
          );
        },
      ),
    );
  }
}
